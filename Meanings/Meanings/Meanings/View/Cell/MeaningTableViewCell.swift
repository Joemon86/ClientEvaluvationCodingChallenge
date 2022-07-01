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

    // Using Property Observer for updating the meaning label in Cell
    var cellViewModel:MeaningCellViewModel? {
        didSet {
            meaning.text = cellViewModel?.meaningText
        }
    }
}
