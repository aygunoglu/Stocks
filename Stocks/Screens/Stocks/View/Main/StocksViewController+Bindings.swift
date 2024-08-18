//
//  StocksViewController+Bindings.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 18.08.2024.
//

import Foundation

extension StocksViewController {
    func stockListDidUpdate() -> VoidHandler? {
        return { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.headerView.configureButtons(
                    fields: self.viewModel.allFields,
                    selectedPrimaryField: self.viewModel.selectedPrimaryField,
                    selectedSecondaryField: self.viewModel.selectedSecondaryField
                )
            }
        }
    }
    
    func stockDataDidUpdate() -> (_ indexPathsToHighlight: [IndexPath]) -> Void  {
        return { [weak self] indexPathsToHighlight in
            guard let self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.highlightRows(for: indexPathsToHighlight)
                self.activityIndicator.shouldAnimate(false)
            }
        }
    }
}
