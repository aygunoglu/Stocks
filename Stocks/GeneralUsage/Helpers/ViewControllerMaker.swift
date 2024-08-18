//
//  ViewControllerMaker.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

final class ViewControllerMaker {
    static func stocksViewController(defaultPrimaryField: Field? = nil, defaultSecondaryField: Field? = nil) -> StocksViewController {
        let viewModel: StocksViewModelProtocol = StocksViewModel(defaultPrimaryField: defaultPrimaryField, defaultSecondaryField: defaultSecondaryField)
        let viewController = StocksViewController(viewModel: viewModel)
        
        return viewController
    }
}
