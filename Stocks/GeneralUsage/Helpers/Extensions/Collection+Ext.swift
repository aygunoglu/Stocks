//
//  Collection+Ext.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 18.08.2024.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
