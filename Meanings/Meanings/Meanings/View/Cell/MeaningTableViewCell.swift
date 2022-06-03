//
//  MeaningTableViewCell.swift
//  Meanings
//
//  Created by 1964058 on 02/06/22.
//

import UIKit

class MeaningTableViewCell: UITableViewCell {
    
    @IBOutlet weak var meaning:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var cellViewModel:MeaningCellViewModel? {
        didSet {
            meaning.text = cellViewModel?.meaningText
        }
    }
}
