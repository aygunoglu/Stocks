//
//  StocksViewController+Setup.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 18.08.2024.
//

import UIKit

extension StocksViewController {
    func setupGeneralView() {
        view.backgroundColor = .systemPink
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = Constants.stocksVCNavigationTitle
    }
    
    func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.allowsMultipleSelection = false
        tableView.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
             tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)]
        )
        
        StocksCellType.allCases.forEach { cellType in
            self.tableView.register(UINib(nibName: cellType.identifier, bundle: nil), forCellReuseIdentifier: cellType.identifier)
        }
    }
    
    func setupBindings() {
        viewModel.stocksDidUpdate = stocksDidUpdate()
    }

}

// MARK: - Bindings
extension StocksViewController {
    func stocksDidUpdate() -> VoidHandler? {
        return { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
