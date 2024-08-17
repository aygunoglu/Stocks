//
//  NetworkLogger.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

class NetworkLogger: ServicePluginProtocol {
    func didReceive(result: Result<URLResponse, Error>, endpoint: EndpointProtocol) {
        let stringToLog: String
        let url = endpoint.url
        let params = url?.queryParameters
        
        switch result {
        case .success:
            stringToLog = "✅ Successful DataTask to: \(url?.absoluteString ?? "")" +
            "\n params = \(params ?? ["no params": "no parameters inserted for this request"])"
            
        case .failure:
            stringToLog = "❌ DataTask Failed to: \(url?.absoluteString ?? "")" +
            "\n params = \(params ?? ["no params": "no parameters inserted for this request"])"
        }
        
        write(string: stringToLog)
    }
    
    private func write(string: String) {
#if DEBUG
        print(string)
        //CLSNSLogv("%@", getVaList([string]))
#else
        Crashlytics.crashlytics().log("\(string)")
        //CLSLogv("%@", getVaList([string]))
#endif
    }
}
