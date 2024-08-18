//
//  StocksViewModel.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

// MARK: - StocksViewModelProtocol
protocol StocksViewModelProtocol: AnyObject {
    var stockListDidUpdate: VoidHandler? { get set }
    var stockDataDidUpdate: ((_ indexPathsToHighlight: [IndexPath]) -> Void)? { get set }
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
    private var timer: Timer?
    private var timerInterval: CGFloat = 1
    
    private let serviceProvider: ServiceProviderProtocol
    
    private var stockList: [Stock]
    private var stockDisplayItems: [StockDisplayModel] = []
    
    // MARK: - Updaters
    var stockListDidUpdate: VoidHandler?
    var stockDataDidUpdate: ((_ indexPathsToHighlight: [IndexPath]) -> Void)?
    
    // MARK: - Fields
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
                self.stockListDidUpdate?()
                loadStockData()
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    private func loadStockData() {
        let endpoint = StocksEndpoint.getStockInfo(
            stocks: stockList.map { $0.tke ?? "" },
            primaryField: selectedPrimaryField,
            secondaryField: selectedSecondaryField
        )
        
        serviceProvider.request(
            endpoint: endpoint,
            responseModel: StocksDetailResponseModel.self
        ) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let responseModel):
                let newModels = responseModel.getDisplayModels(
                    primaryField: selectedPrimaryField,
                    secondaryField: selectedSecondaryField
                ) ?? []
                
                let indexPathsToHighlight = getIndexPathsToHighlight(
                    oldModels: stockDisplayItems,
                    newModels: newModels
                ) ?? []
                
                self.stockDisplayItems = compareLastValues(
                    oldModels: stockDisplayItems,
                    newModels: newModels
                )

                self.stockDataDidUpdate?(indexPathsToHighlight)
                self.configureTimer()
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
}

// MARK: - Compare Helpers
private extension StocksViewModel {
    func getIndexPathsToHighlight(oldModels: [StockDisplayModel], newModels: [StockDisplayModel]) -> [IndexPath]? {
        let indexPathsToHighlight = zip(oldModels, newModels).enumerated()
            .filter { $1.0.lastUpdateDate != $1.1.lastUpdateDate }
            .map { IndexPath(row: $0.0, section: 0) }
        return indexPathsToHighlight
    }
    
    func compareLastValues(oldModels: [StockDisplayModel], newModels: [StockDisplayModel]) -> [StockDisplayModel] {
        var processedDisplayModels = newModels
        
        let differentIndexes = zip(oldModels, newModels).enumerated()
            .filter { $1.0.lastValue != $1.1.lastValue }
            .map { $0.0 }
        
        differentIndexes.forEach { index in
            let newValueFormatted = newModels[index].lastValue?.replacingOccurrences(of: ",", with: ".") ?? ""
            let oldValueFormatted = oldModels[index].lastValue?.replacingOccurrences(of: ",", with: ".") ?? ""
            
            if Double(newValueFormatted) ?? 0 > Double(oldValueFormatted) ?? 0 {
                processedDisplayModels[index].arrow = .upArrow
            } else if Double(newValueFormatted) ?? 0 < Double(oldValueFormatted) ?? 0 {
                processedDisplayModels[index].arrow = .downArrow
            } else {
                processedDisplayModels[index].arrow = .changeless
            }
        }
        
        return processedDisplayModels
    }
}

// MARK: - Timer Helpers
private extension StocksViewModel {
    func configureTimer() {
        DispatchQueue.main.async {
            self.stopTimer()
            self.timer = Timer.scheduledTimer(
                timeInterval: self.timerInterval,
                target: self,
                selector: #selector(self.timerDidComplete),
                userInfo: nil,
                repeats: true
            )
        }
    }
    
    func stopTimer() {
        guard timer != nil else { return }
        timer?.invalidate()
        timer = nil
    }
    
    @objc func timerDidComplete() {
        loadStockData()
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
