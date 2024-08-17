//
//  ServiceProvider.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

final class ServiceProvider: ServiceProviderProtocol {
    public var plugins: [ServicePluginProtocol] = [NetworkLogger()]
    
    init(plugins: [ServicePluginProtocol] = []) {
        self.plugins.append(contentsOf: plugins)
    }
    
    private var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForResource = 10
        return URLSession(configuration: configuration)
    }
    
    public func request<T: Decodable>(endpoint: EndpointProtocol, responseModel: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let request = try prepareRequest(endpoint: endpoint)
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data, let response else { return }
                
                do {
                    let result: Decodable = try self.manageResponse(data: data, response: response, endpoint: endpoint)
                    completion(.success(result))
                } catch let error {
                    completion(.failure(error))
                }
            }
            task.resume()
        } catch let error {
            completion(.failure(error))
        }
    }
    
    private func prepareRequest(endpoint: EndpointProtocol) throws -> URLRequest {
        /// TODO: Insert willSend plugin method here
        do {
            let request = try endpoint.urlRequest()
            return request
        } catch {
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
                plugins.forEach { $0.didReceive(result: .success(response), endpoint: endpoint) }
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
