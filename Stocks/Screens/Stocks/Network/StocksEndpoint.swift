//
//  StocksEndpoint.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

enum StocksEndpoint {
    case getStocks
    case getStockInfo(stocks: [String], primaryField: Field?, secondaryField: Field?)
}

extension StocksEndpoint: EndpointProtocol {
    var baseURL: String {
        switch self {
        case .getStocks:
            return Constants.stocksBaseURL
        case .getStockInfo:
            return Constants.stockInfoBaseURL
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getStocks, 
             .getStockInfo:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getStocks:
            return "/ForeksMobileInterviewSettings"
        case .getStockInfo:
            return "/ForeksMobileInterview"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getStocks:
            return nil
        case .getStockInfo(let stocks, let primaryField, let secondaryField):
            var params: [String: Any] = [:]
            params[Keys.fields.rawValue] = [primaryField, secondaryField].map { $0?.key ?? "" }.joined(separator: ",")
            params[Keys.stocks.rawValue] = stocks.joined(separator: "~")
            return params
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

// MARK: - Keys
extension StocksEndpoint {
  private enum Keys: String {
    case stocks = "stcs"
    case fields
  }
}
