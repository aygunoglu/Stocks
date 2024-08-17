//
//  ServicePluginProtocol.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

/// Plugins receive callbacks to perform addtional tasks wherever a request is sent or received
/// Additional methods to this protocol can be added as the network layer matures.

protocol ServicePluginProtocol {
    /// Called to modify a request before sending
    func willSend(request: URLRequest, endpoint: EndpointProtocol) -> URLRequest
    
    /// Called after a response has been received
    func didReceive(result: Result<URLResponse, Error>, endpoint: EndpointProtocol)
}

extension ServicePluginProtocol {
    func willSend(request: URLRequest, endpoint: EndpointProtocol) -> URLRequest { request }
    func didReceive(result: Result<URLResponse, Error>, endpoint: EndpointProtocol) { }
}
