//
//  String+Ext.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 18.08.2024.
//

import Foundation

extension String {
    var double: Double? {
        let formattedValue = self.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: ".")
        return Double(formattedValue)
    }
}
