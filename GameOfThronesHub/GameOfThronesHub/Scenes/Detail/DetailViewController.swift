//
//  DetailViewController.swift
//  GameOfThronesHub
//
//  Created by Bengi Anıl on 10.09.2024.
//

import UIKit
import Combine

class DetailViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet var mainView: UIView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var houseName: UILabel!
    @IBOutlet private weak var regionName: UILabel!
    @IBOutlet private weak var words: UILabel!
    @IBOutlet private weak var arms: UILabel!
    @IBOutlet private weak var emblemStackView: UIStackView!
    @IBOutlet private weak var armyStackView: UIStackView!
    @IBOutlet private weak var swornMembers: UILabel!
    
    // MARK: Properties
    private var viewModel: DetailViewModel!
    var house: House!
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = DetailViewModel(house: house)
        setupViews()
        setupBindings()
        
        Task {
            await viewModel.getSwornMembers()
        }
    }
    
    // MARK: Methods
    private func setupBindings() {
        viewModel.$swornMembers
            .receive(on: DispatchQueue.main)
            .sink { [weak self] content in
                guard let strongSelf = self else { return }
                strongSelf.swornMembers.text = content
                
                DispatchQueue.main.async {
                    strongSelf.armyStackView.isHidden = content.isEmpty
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupViews() {
        self.title = "Details"
                
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.masksToBounds = true

        houseName.text = viewModel.getHouseName()
        regionName.text = viewModel.getRegionName()
        
        words.isHidden = viewModel.getWords().isEmpty
        words.text = viewModel.getWords()
        
        arms.isHidden = viewModel.getArms().isEmpty
        arms.text = viewModel.getArms()
        
        emblemStackView.isHidden = viewModel.getArms().isEmpty
    }
}
