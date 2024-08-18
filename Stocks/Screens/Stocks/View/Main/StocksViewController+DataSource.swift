//
//  StocksViewController+DataSource.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 18.08.2024.
//

import UIKit

extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCellCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let stockItem = viewModel.getStockItem(for: indexPath),
              let cell = tableView.dequeueReusableCell(withIdentifier: StocksCellType.stockCell.identifier, for: indexPath) as? StockCell else {
            print("error while dequeing cell")
            fatalError()
        }
        
        cell.configureCell(with: stockItem)
        return cell
    }
}
