//
//  StocksEndpoint.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

enum StocksEndpoint {
    case getStocks
}

extension StocksEndpoint: EndpointProtocol {
    var baseURL: String {
        switch self {
        default:
            return Constants.stocksBaseURL
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getStocks:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getStocks:
            return "/ForeksMobileInterviewSettings"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getStocks:
            return nil
        }
    }
    
    var body: [String : Any]? {
        return nil
    }
    
    var httpHeaders: [String : String]? {
        return nil
    }
    
    var mockFile: String? {
        return nil
    }
}
