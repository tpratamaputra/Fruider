//
//  FruitDetailTableViewCell.swift
//  Frudder!
//
//  Created by Thomas Pratama Putra on 25/04/19.
//  Copyright © 2019 NA. All rights reserved.
//

import UIKit

class FruitDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var fruitImage: UIImageView!
    @IBOutlet weak var fruitTitle: UILabel!
    @IBOutlet weak var fruitDescription: UILabel!
    @IBOutlet weak var nutritionTitle: UILabel!
    @IBOutlet weak var nutritionDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
