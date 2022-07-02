//
//  HomeViewController.swift
//  SampleApp
//
//  Created by Julio Fernandes on 22/03/22.
//

import UIKit

final class HomeViewController: UITableViewController {
    
    private var service: ServiceProtocol = Service()
    private var model: HomeModel?
    private var numberOfFixedElements: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        fetchData()
    }
    
    @objc func didTapFixedIncone() {
        performSegue(withIdentifier: "showFixedIncone", sender: nil)
    }
    
    @objc func didTapStocks() {
        performSegue(withIdentifier: "showStocks", sender: nil)
    }
    
    @objc func didTapFunds() {
        performSegue(withIdentifier: "showFunds", sender: nil)
    }
    
    @objc func didTapTreasury() {
        performSegue(withIdentifier: "showTreasury", sender: nil)
    }

}

// MARK: Service methods
extension HomeViewController {
    func fetchData() {
        service.load(endpoint: .home) { [weak self] (response: Result<HomeModel, ServiceError>) in
            switch response {
            case .success(let data): self?.showData(data)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}

// MARK: State control methods
extension HomeViewController {
    
    func showData(_ data: HomeModel) {
        self.model = data
        tableView.reloadData()
    }
}

// MARK: - Table view data source
extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = self.model else {
            return 0
        }
        return numberOfFixedElements + model.products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.model else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0: return makeTitleView(title: model.h1, indexPath: indexPath)
        case 1: return makeMyPatrimonyView(viewModel: model.patrimony, indexPath:indexPath)
        case 2: return makeTitleView(title: model.h3, indexPath: indexPath)
        default: return makeCollectionProductsView(viewModel: model.products[indexPath.row - numberOfFixedElements], indexPath: indexPath)
        }
    }
    
}

// MARK: Internal methods
extension HomeViewController {
    
    func registerCells() {
        tableView.register(UINib(nibName: "TitleViewCell", bundle: nil), forCellReuseIdentifier: TitleViewCell.cellIdentifier)
        tableView.register(UINib(nibName: "MyPatrimonyViewCell", bundle: nil), forCellReuseIdentifier: MyPatrimonyViewCell.cellIdentifier)
        tableView.register(UINib(nibName: "CollectionProductsViewCell", bundle: nil), forCellReuseIdentifier: CollectionProductsViewCell.cellIdentifier)
    }
    
    func makeTitleView(title: String, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleViewCell.cellIdentifier, for: indexPath) as! TitleViewCell
        cell.setup(title: title)
        return cell
    }
    
    func makeMyPatrimonyView(viewModel: PatrimonyModel, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyPatrimonyViewCell.cellIdentifier, for: indexPath) as! MyPatrimonyViewCell
        cell.setup(model: viewModel)
        return cell
    }
    
    func makeCollectionProductsView(viewModel: CollectionProductModel, indexPath: IndexPath) -> UITableViewCell {
        let model = CollectionProductModel(left: viewModel.left, right: viewModel.right)
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionProductsViewCell.cellIdentifier, for: indexPath) as! CollectionProductsViewCell
        cell.setup(model: model)
        return cell
    }
    
}
