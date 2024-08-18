//
//  StocksViewController.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import UIKit

// MARK: - StocksViewController
final class StocksViewController: UIViewController {
    var tableView: UITableView!
    var headerView: StocksHeaderView!
    
    var activityIndicator = ActivityIndicator()
    
    var viewModel: StocksViewModelProtocol
    
    init(viewModel: StocksViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGeneralView()
        setupHeaderView()
        setupTableView()
        setupBindings()
        applyActivityIndicator()
        viewModel.loadStockList()
    }
}

// MARK: - StocksHeaderViewDelegate
extension StocksViewController: StocksHeaderViewDelegate {
    func primaryFieldDidChange(to field: Field) {
        viewModel.selectedPrimaryField = field
    }
    
    func secondaryFieldDidChange(to field: Field) {
        viewModel.selectedSecondaryField = field
    }
}
