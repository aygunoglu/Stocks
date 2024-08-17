//
//  EndpointProtocol.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var httpHeaders: [String: String]? { get }
    var body: [String: Any]? { get }
    var mockFile: String? { get }
}

extension EndpointProtocol {
    func urlRequest() throws -> URLRequest {
        guard let url = self.url else {
            throw APIError.invalidRequest(description: "Invalid URL")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("true", forHTTPHeaderField: "X-Use-Cache")
        
        if let httpHeaders {
            httpHeaders.forEach { headerValue, headerField in
                urlRequest.addValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        
        if let body {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                throw APIError.invalidRequest(description: "HTTP body encoding error")
            }
        }
        
        return urlRequest
    }
    
    public var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        
        if let parameters = parameters {
            urlComponents?.queryItems = parameters.map { (key: String, value: Any) -> URLQueryItem in
                let valueString = String(describing: value)
                return URLQueryItem(name: key, value: valueString)
            }
        }
        
        return urlComponents?.url
    }
}
