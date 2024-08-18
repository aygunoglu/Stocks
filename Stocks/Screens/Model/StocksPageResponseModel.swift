//
//  StocksResponseModel.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

struct StocksPageResponseModel: Codable {
    let stocks: [Stock]?
    let fields: [Field]?
    
    enum CodingKeys: String, CodingKey {
        case stocks = "mypageDefaults"
        case fields = "mypage"
    }
}

struct Field: Codable {
    let name, key: String?
}

struct Stock: Codable {
    let cod, gro, tke, def: String?
}
