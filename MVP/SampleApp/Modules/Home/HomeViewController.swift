//
//  HomeViewController.swift
//  SampleApp
//
//  Created by Julio Fernandes on 22/03/22.
//

import UIKit

final class HomeViewController: UITableViewController {
    
    private lazy var presenter: HomeViewPresenterInput = {
        let presenter = HomeViewPresenter()
        presenter.viewController = self
        return presenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        presenter.fetchData()
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: "TitleViewCell", bundle: nil), forCellReuseIdentifier: TitleViewCell.cellIdentifier)
        tableView.register(UINib(nibName: "MyPatrimonyViewCell", bundle: nil), forCellReuseIdentifier: MyPatrimonyViewCell.cellIdentifier)
        tableView.register(UINib(nibName: "CollectionProductsViewCell", bundle: nil), forCellReuseIdentifier: CollectionProductsViewCell.cellIdentifier)
    }

}

// MARK: State control methods
extension HomeViewController: HomeViewPresenterOutput {
    
    func showData() {
        tableView.reloadData()
    }
}

// MARK: - Table view data source
extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter.tableView(tableView, cellForRowAt: indexPath)
    }
    
}

// MARK: Navigation flow
extension HomeViewController {
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1: showPortfolio()
        default: break
        }
    }
    
    func showPortfolio() {
        performSegue(withIdentifier: "PortfolioDetail", sender: nil)
    }
}
