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
    var allFields: [Field] { get }    
    var selectedPrimaryField: Field? { get set }
    var selectedSecondaryField: Field? { get set }
    func loadStockList()
    
    // TableView Helpers
    func getSectionCount() -> Int
    func getCellCount() -> Int
    func getStockItem(for indexPath: IndexPath) -> StockDisplayModel?
}

// MARK: - StocksViewModel
final class StocksViewModel: StocksViewModelProtocol {
    private let serviceProvider: ServiceProviderProtocol
    private var stockList: [Stock]
    private var stockDisplayItems: [StockDisplayModel] = []
    
    var stocksDidUpdate: VoidHandler?
    
    var allFields: [Field]
    var selectedPrimaryField: Field? {
        didSet {
            loadStockData()
        }
    }
    var selectedSecondaryField: Field? {
        didSet {
            loadStockData()
        }
    }
    
    init(
        serviceProvider: ServiceProviderProtocol = ServiceProvider(),
        stockList: [Stock] = [],
        fields: [Field] = [],
        defaultPrimaryField: Field? = nil,
        defaultSecondaryField: Field? = nil
    ) {
        self.serviceProvider = serviceProvider
        self.stockList = stockList
        self.allFields = fields
        self.selectedPrimaryField = defaultPrimaryField
        self.selectedSecondaryField = defaultSecondaryField
    }
    
    // MARK: - Networking
    func loadStockList() {
        serviceProvider.request(
            endpoint: StocksEndpoint.getStocks,
            responseModel: StocksPageResponseModel.self
        ) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let responseModel):
                self.allFields = responseModel.fields ?? []
                self.stockList = responseModel.stocks ?? []
                loadStockData()
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    private func loadStockData() {
        serviceProvider.request(
            endpoint: StocksEndpoint.getStockInfo(
                stocks: stockList.map { $0.tke ?? "" },
                primaryField: selectedPrimaryField,
                secondaryField: selectedSecondaryField
            ),
            responseModel: StocksDetailResponseModel.self
        ) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let responseModel):
                self.stockDisplayItems = responseModel.getDisplayModels(
                    primaryField: selectedPrimaryField,
                    secondaryField: selectedSecondaryField
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
        return stockDisplayItems.count
    }
    
    func getStockItem(for indexPath: IndexPath) -> StockDisplayModel? {
        return stockDisplayItems[safe: indexPath.row]
    }
}
