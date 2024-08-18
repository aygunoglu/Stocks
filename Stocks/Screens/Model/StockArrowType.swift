//
//  StockArrowType.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 18.08.2024.
//

import UIKit

enum StockArrowType {
    case upArrow, downArrow, changeless
    
    var image: UIImage? {
        switch self {
        case .upArrow:
            return UIImage(systemName: "arrow.up.square.fill")
        case .downArrow:
            return UIImage(systemName: "arrow.down.square.fill")
        case .changeless:
            return UIImage(systemName: "rectangle.portrait.fill")
        }
    }
    
    var tintColor: UIColor? {
        switch self {
        case .upArrow:
            return .systemGreen
        case .downArrow:
            return .systemRed
        case .changeless:
            return .label
        }
    }
}
