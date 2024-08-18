//
//  Constants.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

struct Constants {
    static let stocksBaseURL = "https://sui7963dq6.execute-api.eu-central-1.amazonaws.com"
    static let stockInfoBaseURL = "https://sui7963dq6.execute-api.eu-central-1.amazonaws.com"
    
    static let stocksVCNavigationTitle = "Stoklar"
    
    static let stockCellIdentifier = "StockCell"
    
    static let defaultPrimaryField = Field(name: "Son", key: "las")
    static let defaultSecondaryField = Field(name: "Fark", key: "ddi")
}
