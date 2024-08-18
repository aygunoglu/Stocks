//
//  StocksCellType.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

enum StocksCellType: CaseIterable {
    case stockCell
    
    var identifier: String {
        switch self {
        case .stockCell:
            return Constants.stockCellIdentifier
        }
    }
}
