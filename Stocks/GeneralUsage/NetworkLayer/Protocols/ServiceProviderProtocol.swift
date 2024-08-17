//
//  ServiceProviderProtocol.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

protocol ServiceProviderProtocol {
    func request<T: Decodable>(endpoint: EndpointProtocol, responseModel: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}
