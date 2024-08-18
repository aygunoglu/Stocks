//
//  StocksViewModel.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

// MARK: - StocksViewModelProtocol
protocol StocksViewModelProtocol: AnyObject {
    var stocksDidUpdate: VoidHandler? { get set }
    func loadStocks()
    
    // TableView Helpers
    func getSectionCount() -> Int
    func getCellCount() -> Int
    func getStockItem(for indexPath: IndexPath) -> StockDisplayModel?
}

// MARK: - StocksViewModel
final class StocksViewModel: StocksViewModelProtocol {
    private let serviceProvider: ServiceProviderProtocol
    var fields: [Field]?
    
    var selectedPrimaryField: Field?
    var selectedSecondaryField: Field?
    
    var stockItems: [StockDisplayModel] = []
    var stocksDidUpdate: VoidHandler?
    
    init(serviceProvider: ServiceProviderProtocol = ServiceProvider()) {
      self.serviceProvider = serviceProvider
    }
    
    // MARK: - Networking
    func loadStocks() {
        serviceProvider.request(
            endpoint: StocksEndpoint.getStocks,
            responseModel: StocksPageResponseModel.self
        ) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let responseModel):
                self.fields = responseModel.fields
                loadStockDetails(
                    stocks: responseModel.stocks?.map { $0.tke ?? "" },
                    primaryField: selectedPrimaryField,
                    secondaryField: selectedSecondaryField
                )
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadStockDetails(
        stocks: [String]?,
        primaryField: Field?,
        secondaryField: Field?
    ) {
        guard let stocks else { return }
        
        serviceProvider.request(
            endpoint: StocksEndpoint.getStockInfo(
                stocks: stocks,
                primaryField: primaryField,
                secondaryField: secondaryField
            ),
            responseModel: StocksDetailResponseModel.self
        ) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let responseModel):
                self.stockItems = responseModel.getDisplayModels(
                    primaryField: primaryField,
                    secondaryField: secondaryField
                ) ?? []
                self.stocksDidUpdate?()
            case .failure(let error):
                print(error)
            }
        }
    }

}

// MARK: TableView Helpers
extension StocksViewModel {
    func getSectionCount() -> Int {
        return 1
    }
    
    func getCellCount() -> Int {
        return stockItems.count
    }
    
    func getStockItem(for indexPath: IndexPath) -> StockDisplayModel? {
        return stockItems[safe: indexPath.row]
    }
}
