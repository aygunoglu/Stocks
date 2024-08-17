//
//  ViewControllerMaker.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

final class ViewControllerMaker {
    static func stocksViewController() -> StocksViewController {
        let viewModel: StocksViewModelProtocol = StocksViewModel()
        let viewController = StocksViewController(viewModel: viewModel)
        
        return viewController
    }
}
