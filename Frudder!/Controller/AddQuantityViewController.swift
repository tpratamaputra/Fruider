//
//  AddQuantityViewController.swift
//  Frudder!
//
//  Created by Thomas Pratama Putra on 23/04/19.
//  Copyright © 2019 NA. All rights reserved.
//

import UIKit
import RealmSwift

class AddQuantityViewController: UIViewController {
    
    // MARK: - Declare variable(s) here
    
    let realm = try! Realm()
    
    var fruitArray: Results<Fruit>?
    var userArray: Results<User>?
    
    var numberLOV : [Int] = [1, 2, 3, 4, 5]
    var tempFruitID: Int = Int()
    var stepperValue: Int = Int()
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var fruitName: UILabel!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var fruitImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        loadObj()
        
        stepperOutlet.maximumValue = 5
        stepperOutlet.minimumValue = 1
        stepperOutlet.autorepeat = false
        stepperOutlet.wraps = true
        
        quantityLabel.text = Int(stepperOutlet.minimumValue).description
        fruitName.text = fruitArray![tempFruitID].fruitName
        
        fruitImage.image = UIImage(named: "\(tempFruitID)")
        fruitImage.layer.cornerRadius = fruitImage.frame.size.width / 2
        fruitImage.clipsToBounds = true
    }
    
    func loadObj () {
        fruitArray = realm.objects(Fruit.self)
        userArray = realm.objects(User.self)
    }
    
    func saveObj (object: User) {
        do{
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error writing obj. w/ error message: \(error)")
        }
    }
    
    @IBAction func stepperButtonPressed(_ sender: Any) {
        let stepperSender = sender as! UIStepper
        quantityLabel.text = Int(stepperSender.value).description
        stepperValue = Int(stepperSender.value)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        do {
            try realm.write {
                let tempDataObject = User()
                tempDataObject.stackDate = Date()
                tempDataObject.fruitIDtoEat = tempFruitID
                tempDataObject.quantityToEat = stepperValue
                realm.add(tempDataObject)
            }
        } catch {
            print("\(error)")

        }
        navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
