//
//  StockCell.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 18.08.2024.
//

import UIKit

final class StockCell: UITableViewCell {
    @IBOutlet private weak var stockNameLabel: UILabel!
    @IBOutlet private weak var lastUpdateLabel: UILabel!
    @IBOutlet private weak var primaryFieldLabel: UILabel!
    @IBOutlet private weak var secondaryFieldLabel: UILabel!
    @IBOutlet private weak var arrowImageView: UIImageView!
    
    func configureCell(with stock: StockDisplayModel) {
        stockNameLabel.text = stock.name
        lastUpdateLabel.text = stock.lastUpdateDate
        
        primaryFieldLabel.text = stock.primaryFieldValue ?? "-"
        secondaryFieldLabel.text = stock.secondaryFieldValue ?? "-"
        
        primaryFieldLabel.textColor = stock.primaryFieldColor
        secondaryFieldLabel.textColor = stock.secondaryFieldColor
        
        arrowImageView.image = stock.arrow.image
        arrowImageView.tintColor = stock.arrow.tintColor
    }
}
