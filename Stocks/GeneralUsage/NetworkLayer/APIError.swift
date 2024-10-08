//
//  APIError.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

enum APIError: Error {
    case invalidRequest(description: String)
    case requestFailed(description: String)
    case invalidData
    case responseUnsuccessful(description: String)
    case jsonConversionFailure(description: String)
    case jsonParsingFailure
    case failedSerialization
    case noInternet
    
    var customDescription: String {
        switch self {
        case let .invalidRequest(description): return description
        case let .requestFailed(description): return "Request Failed: \(description)"
        case .invalidData: return "Invalid Data"
        case let .responseUnsuccessful(description): return "Unsuccessful: \(description)"
        case let .jsonConversionFailure(description): return "JSON Conversion Failure: \(description)"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .failedSerialization: return "Serialization failed."
        case .noInternet: return "No internet connection"
        }
    }
}
