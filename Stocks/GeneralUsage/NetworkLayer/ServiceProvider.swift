//
//  ServiceProvider.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

final class ServiceProvider: ServiceProviderProtocol {
    private var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForResource = 10
        return URLSession(configuration: configuration)
    }
    
    public func request<T: Decodable>(endpoint: EndpointProtocol, responseModel: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
        do {
            let request = try prepareRequest(endpoint: endpoint)
            let task = session.dataTask(with: request) { [weak self] data, response, error in
                guard let self, error == nil else {
                    completion(.failure(.invalidRequest(description: "Invalid URL")))
                    return
                }
                
                guard let data, let response else {
                    completion(.failure(.invalidData))
                    return
                }
                
                do {
                    let result: T = try self.manageResponse(data: data, response: response, endpoint: endpoint)
                    completion(.success(result))
                } catch {
                    completion(.failure(error as? APIError ?? APIError.jsonParsingFailure))
                }
            }
            task.resume()
        } catch let error {
            completion(.failure(error as? APIError ?? APIError.invalidRequest(description: "Invalid Request")))
        }
    }
    
    private func prepareRequest(endpoint: EndpointProtocol) throws -> URLRequest {
        do {
            let request = try endpoint.urlRequest()
            return request
        } catch let error {
            throw error
        }
    }
    
    private func manageResponse<T: Decodable>(data: Data, response: URLResponse, endpoint: EndpointProtocol) throws -> T {
        guard let response = response as? HTTPURLResponse else {
            throw APIError.responseUnsuccessful(description: "Invalid API Response")
        }
        
        switch response.statusCode {
        case 200...299:
            do {
                let responseModel = try JSONDecoder().decode(T.self, from: data)
                return responseModel
            } catch let error {
                print("❌", error)
                throw APIError.jsonParsingFailure
            }
        default:
            throw APIError.responseUnsuccessful(description: "Invalid Response")
        }
    }
}
