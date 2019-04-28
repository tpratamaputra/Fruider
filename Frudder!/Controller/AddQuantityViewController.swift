//
//  AddQuantityViewController.swift
//  Frudder!
//
//  Created by Thomas Pratama Putra on 23/04/19.
//  Copyright © 2019 NA. All rights reserved.
//

import UIKit
import RealmSwift
import SVProgressHUD

class AddQuantityViewController: UIViewController {
    
    // MARK: - Declare variable(s) here
    let realm = try! Realm()
    
    var fruitArray: Results<Fruit>?
    var userArray: Results<User>?
    
    var fruitRcv = Fruit()
    var stepperValue: Int = Int()
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var fruitName: UILabel!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var fruitImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch (fruitRcv.fruitID) {
        case 0:
            view.backgroundColor = UIColor.flatRedColorDark()
        case 1:
            view.backgroundColor = UIColor.flatGreen()
        case 2:
            view.backgroundColor = UIColor.flatYellow()
        case 3:
            view.backgroundColor = UIColor.flatOrange()
        case 4:
            view.backgroundColor = UIColor.flatRed()
        default:
            view.backgroundColor = .white
        }
        
        loadObj()
        
        stepperOutlet.maximumValue = 5
        stepperOutlet.minimumValue = 0
        stepperOutlet.autorepeat = false
        stepperOutlet.wraps = false
        
        quantityLabel.text = Int(stepperOutlet.minimumValue).description
        quantityLabel.textColor = .white
        fruitName.text = fruitArray![fruitRcv.fruitID].fruitName
        fruitName.textColor = .white
        
        fruitImage.image = UIImage(named: "\(fruitRcv.fruitID)")
        fruitImage.layer.cornerRadius = 17
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
        if stepperValue != 0 {
            do {
                try realm.write {
                    let tempDataObject = User()
                    tempDataObject.stackDate = Date()
                    tempDataObject.fruitIDtoEat = fruitRcv.fruitID
                    tempDataObject.quantityToEat = stepperValue
                    realm.add(tempDataObject)
                }
            } catch {
                print("\(error)")

            }
//            SVProgressHUD.showSuccess(withStatus: "Success!")
//            SVProgressHUD.dismiss(withDelay: 0.75)
        }
        else {
//            SVProgressHUD.showError(withStatus: "Try again!")
        }
        Timer.scheduledTimer(timeInterval: 0, target: self, selector: Selector(("dismissVC")), userInfo: nil, repeats: false)
    }
    
    @objc func dismissVC () {
        navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
