//
//  StocksViewModel.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import Foundation

protocol StocksViewModelProtocol: AnyObject {
    var dataUpdated: VoidHandler? { get set }
    func getSectionCount() -> Int
    func getCellCount() -> Int
    func loadStocks()
}

final class StocksViewModel: StocksViewModelProtocol {
    private let serviceProvider: ServiceProviderProtocol
    
    var dataUpdated: VoidHandler?
    
    init(serviceProvider: ServiceProviderProtocol = ServiceProvider()) {
      self.serviceProvider = serviceProvider
    }
    
    func loadStocks() {
        serviceProvider.request(
            endpoint: StocksEndpoint.getStocks,
            responseModel: StocksResponseModel.self
        ) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let responseModel):
                print(responseModel)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getSectionCount() -> Int {
        return 0
    }
    
    func getCellCount() -> Int {
        return 0
    }
}
