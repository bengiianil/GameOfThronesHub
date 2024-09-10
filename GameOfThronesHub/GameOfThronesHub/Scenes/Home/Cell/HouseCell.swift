//
//  HouseCell.swift
//  GameOfThronesHub
//
//  Created by Bengi Anıl on 9.09.2024.
//

import UIKit

class HouseCell: UITableViewCell {
    @IBOutlet weak var houseName: UILabel!
    @IBOutlet weak var houseRegion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        houseName.text = ""
        houseRegion.text = ""
    }
    
    func setupHouseCell(with viewModel: HouseCellViewModel) {
        houseName.text = viewModel.getHouseName()
        houseRegion.text = viewModel.getHouseRegion()
    }
}
