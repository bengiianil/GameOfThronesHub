//
//  HomeViewController.swift
//  GameOfThronesHub
//
//  Created by Bengi Anıl on 8.09.2024.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Properties
    private var homeViewModel: HomeViewModel!
    private var dataSource: UITableViewDiffableDataSource<Section, House>!
    private var cancellables = Set<AnyCancellable>()

    enum Section {
        case main
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeViewModel = HomeViewModel()
        setupViews()
        setupBindings()
        Task {
            await homeViewModel.getHouseList()
        }
    }
    
    // MARK: Methods
    func setupBindings() {
        homeViewModel.$houseContent
            .receive(on: DispatchQueue.main)
            .sink { [weak self] content in
                self?.updateDataSource(with: content ?? [])
            }
            .store(in: &cancellables)
    }
    
    func setupViews() {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Houses"

        dataSource = UITableViewDiffableDataSource<Section, House>(tableView: tableView) { tableView, indexPath, house in
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseCell", for: indexPath) as! HouseCell
            if let item = self.homeViewModel.getCellViewModel(atIndex: indexPath.row) {
                cell.setupHouseCell(with: item)
            }
            
            return cell
        }
        
        tableView.dataSource = dataSource
    }
    
    func updateDataSource(with houses: [House]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, House>()
        snapshot.appendSections([.main])
        snapshot.appendItems(houses)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}
