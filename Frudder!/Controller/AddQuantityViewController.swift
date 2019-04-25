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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.flatLime()
        
        stepperOutlet.maximumValue = 5
        stepperOutlet.minimumValue = 1
        stepperOutlet.autorepeat = false
        stepperOutlet.wraps = false
        
        quantityLabel.text = Int(stepperOutlet.minimumValue).description
    }
    
    @IBAction func stepperButtonPressed(_ sender: Any) {
        let stepperSender = sender as! UIStepper
        quantityLabel.text = Int(stepperSender.value).description
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}


