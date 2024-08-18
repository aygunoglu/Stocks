//
//  StocksViewController+TableDelegate.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 18.08.2024.
//

import UIKit

extension StocksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView.configureButtons(
            fields: viewModel.allFields,
            selectedPrimaryField: viewModel.selectedPrimaryField,
            selectedSecondaryField: viewModel.selectedSecondaryField
        )
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
