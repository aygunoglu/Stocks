//
//  StocksViewController.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 17.08.2024.
//

import UIKit

final class StocksViewController: UIViewController {
    var tableView: UITableView!
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
        setupTableView()
        setupBindings()
        viewModel.loadStocks()
    }
    
    func setupGeneralView() {
        view.backgroundColor = .systemPink
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = Constants.stocksVCNavigationTitle
    }
    
    func setupTableView() {
        self.tableView = UITableView(frame: .zero, style: .plain)
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        self.tableView.allowsMultipleSelection = false
        self.tableView.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [self.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             self.tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
             self.tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)]
        )
        
        StocksCellType.allCases.forEach { cellType in
            self.tableView.register(UINib(nibName: cellType.identifier, bundle: nil), forCellReuseIdentifier: cellType.identifier)
        }
    }
    
    func setupBindings() {
        viewModel.stocksDidUpdate = stocksDidUpdate()
    }
    
    func stocksDidUpdate() -> VoidHandler? {
        return { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCellCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let stockItem = viewModel.getStockItem(for: indexPath),
              let cell = tableView.dequeueReusableCell(withIdentifier: StocksCellType.stockCell.identifier, for: indexPath) as? StockCell else {
            print("error while dequeing cell")
            fatalError()
        }
        
        cell.configureCell(with: stockItem)
        return cell
    }
}
