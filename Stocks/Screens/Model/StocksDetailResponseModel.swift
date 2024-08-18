//
//  StocksDetailResponseModel.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 18.08.2024.
//

import UIKit

struct StocksDetailResponseModel: Codable {
    private let dict: [[String: String]]?
    
    func getDisplayModels(
        primaryField: Field?,
        secondaryField: Field?
    ) -> [StockDisplayModel]? {
        return dict?.compactMap({ stockDict in
            StockDisplayModel(
                name: stockDict["tke"],
                lastUpdateDate: stockDict["clo"],
                lastValue: stockDict["las"],
                primaryFieldValue: stockDict[primaryField?.key ?? ""],
                secondaryFieldValue: stockDict[secondaryField?.key ?? ""],
                primaryFieldKey: primaryField?.key,
                secondaryFieldKey: secondaryField?.key
            )
        })
    }
    
    enum CodingKeys: String, CodingKey {
        case dict = "l"
    }
}

struct StockDisplayModel {
    let name: String?
    let lastUpdateDate: String?
    let lastValue: String?
    let primaryFieldValue: String?
    let secondaryFieldValue: String?
    
    let primaryFieldKey: String?
    let secondaryFieldKey: String?
    
    var arrow: StockArrowType = .changeless
    
    var primaryFieldColor: UIColor? {
        guard (primaryFieldKey == "pdd" || primaryFieldKey == "ddi") else {
            return .label
        }
        
        if primaryFieldValue?.first == "-" {
            return .systemRed
        } else  {
            return .systemGreen
        }
    }
    
    var secondaryFieldColor: UIColor? {
        guard (secondaryFieldKey == "pdd" || secondaryFieldKey == "ddi") else {
            return .label
        }
        
        if secondaryFieldValue?.first == "-" {
            return .systemRed
        } else  {
            return .systemGreen
        }
    }
}
