//
//  StocksResponseModel.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

struct StocksResponseModel: Codable {
    let mypageDefaults: [MypageDefault]?
    let mypage: [Mypage]?
}

struct Mypage: Codable {
    let name, key: String?
}

struct MypageDefault: Codable {
    let cod, gro, tke, def: String?
}
