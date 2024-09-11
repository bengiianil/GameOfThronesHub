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
    private var viewModel: HomeViewModel!
    private var dataSource: UITableViewDiffableDataSource<Section, House>!
    private var cancellables = Set<AnyCancellable>()

    enum Section {
        case main
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HomeViewModel()
        setupViews()
        setupBindings() 
    }
    
    // MARK: Methods
    private func setupBindings() {
        viewModel.$houseContent
            .receive(on: DispatchQueue.main)
            .sink { [weak self] content in
                guard let strongSelf = self else { return }
                strongSelf.updateDataSource(with: content)
            }
            .store(in: &cancellables)
    }
    
    private func setupViews() {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Houses"

        dataSource = UITableViewDiffableDataSource<Section, House>(tableView: tableView) { tableView, indexPath, house in
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseCell", for: indexPath) as! HouseCell
            if let item = self.viewModel.getCellViewModel(atIndex: indexPath.row) {
                cell.setupHouseCell(with: item)
            }
            
            return cell
        }
        
        tableView.dataSource = dataSource
    }
    
    private func updateDataSource(with houses: [House]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, House>()
        snapshot.appendSections([.main])
        tableView.beginUpdates()
        snapshot.appendItems(houses)
        tableView.endUpdates()
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    func navigateToDetailViewController(item: House) {
        let detailViewController: DetailViewController = UIStoryboard.createViewController()
        detailViewController.house = item
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UITableViewDelegate -
extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToDetailViewController(item: item)
    }
}


// MARK: - UIScrollViewDelegate -
extension HomeViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let offsetY = scrollView.contentOffset.y
        let height = scrollView.frame.size.height
        
        if offsetY > (contentHeight - height - 100) {
            self.tableView.tableFooterView = createSpinnerFooter()

            Task {
                await viewModel.getHouseList()
            }
        }
    }
}
