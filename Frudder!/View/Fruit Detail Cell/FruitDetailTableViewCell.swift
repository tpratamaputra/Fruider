//
//  FruitDetailTableViewCell.swift
//  Frudder!
//
//  Created by Thomas Pratama Putra on 25/04/19.
//  Copyright © 2019 NA. All rights reserved.
//

import UIKit

protocol infoButtonPressedDelegate {
    func infoButtonPressed(fruit: Fruit)
}

class FruitDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var fruitImage: UIImageView!
    @IBOutlet weak var fruitTitle: UILabel!
    @IBOutlet weak var fruitDescription: UILabel!
    
    var fruit: Fruit!
    
    var delegate: infoButtonPressedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        delegate?.infoButtonPressed(fruit: fruit)
    }
}
