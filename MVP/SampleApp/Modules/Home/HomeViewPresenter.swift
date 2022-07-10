//
//  HomeViewPresenter.swift
//  MVP
//
//  Created by Julio Fernandes on 10/07/22.
//

import UIKit

protocol HomeViewPresenterInput: AnyObject {
    func fetchData()
    func numberOfRowsInSection() -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

protocol HomeViewPresenterOutput: AnyObject {
    func showData()
}

final class HomeViewPresenter: HomeViewPresenterInput {
    
    weak var viewController: HomeViewPresenterOutput?
    private var service: ServiceProtocol = Service()
    private var model: HomeModel?
    private var numberOfFixedElements: Int = 3
    
    func fetchData() {
        service.load(endpoint: .home) { [weak self] (response: Result<HomeModel, ServiceError>) in
            switch response {
            case .success(let data):
                self?.model = data
                self?.viewController?.showData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        guard let model = self.model else {
            return 0
        }
        return numberOfFixedElements + model.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.model else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0: return makeTitleView(tableView: tableView, title: model.h1, indexPath: indexPath)
        case 1: return makeMyPatrimonyView(tableView: tableView, viewModel: model.patrimony, indexPath:indexPath)
        case 2: return makeTitleView(tableView: tableView, title: model.h3, indexPath: indexPath)
        default: return makeCollectionProductsView(tableView: tableView, viewModel: model.products[indexPath.row - numberOfFixedElements], indexPath: indexPath)
        }
    }
}

// MARK: Internal methods
extension HomeViewPresenter {
    
    func makeTitleView(tableView: UITableView, title: String, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleViewCell.cellIdentifier, for: indexPath) as! TitleViewCell
        cell.setup(title: title)
        return cell
    }
    
    func makeMyPatrimonyView(tableView: UITableView, viewModel: PatrimonyModel, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyPatrimonyViewCell.cellIdentifier, for: indexPath) as! MyPatrimonyViewCell
        cell.setup(model: viewModel)
        return cell
    }
    
    func makeCollectionProductsView(tableView: UITableView, viewModel: CollectionProductModel, indexPath: IndexPath) -> UITableViewCell {
        let model = CollectionProductModel(left: viewModel.left, right: viewModel.right)
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionProductsViewCell.cellIdentifier, for: indexPath) as! CollectionProductsViewCell
        cell.setup(model: model)
        return cell
    }
    
}
