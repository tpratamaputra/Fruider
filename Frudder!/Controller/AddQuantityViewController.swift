//
//  AddQuantityViewController.swift
//  Frudder!
//
//  Created by Thomas Pratama Putra on 23/04/19.
//  Copyright © 2019 NA. All rights reserved.
//

import UIKit

class AddQuantityViewController: UIViewController {
    
    // MARK: - Declare variable(s) here
    var tempFruit : String = String()
    
    var numberLOV : [String] = ["1", "2", "3", "4", "5"]
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var fruitImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        stepperOutlet.maximumValue = 5
        stepperOutlet.minimumValue = 1
        stepperOutlet.autorepeat = false
        stepperOutlet.wraps = true
        
        quantityLabel.text = Int(stepperOutlet.minimumValue).description
        
        fruitImage.image = #imageLiteral(resourceName: "strawberry")
        fruitImage.layer.cornerRadius = fruitImage.frame.size.width / 2
        fruitImage.clipsToBounds = true
    }
    
    @IBAction func stepperButtonPressed(_ sender: Any) {
        let stepperSender = sender as! UIStepper
        quantityLabel.text = Int(stepperSender.value).description
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
