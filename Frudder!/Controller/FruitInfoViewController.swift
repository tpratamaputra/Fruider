//
//  FruitInfoViewController.swift
//  Frudder!
//
//  Created by Thomas Pratama Putra on 26/04/19.
//  Copyright © 2019 NA. All rights reserved.
//

import UIKit
import RealmSwift

class FruitInfoViewController: UIViewController {
    
    @IBOutlet weak var fruitDetailImage: UIImageView!
    @IBOutlet weak var fruitDetailText: UILabel!
    
    let realm = try! Realm()
    
    var fruitArray: Results<Fruit>?
    var userArray: Results<User>?
    
    var fruitID: Int!
    
    @IBOutlet weak var servingPortion: UILabel!
    @IBOutlet weak var caloriesContent: UILabel!
    @IBOutlet weak var totalFat: UILabel!
    @IBOutlet weak var sodContent: UILabel!
    @IBOutlet weak var carbContent: UILabel!
    @IBOutlet weak var sugarContent: UILabel!
    @IBOutlet weak var proteinContent: UILabel!
    @IBOutlet weak var vitaminAContent: UILabel!
    @IBOutlet weak var vitaminCContent: UILabel!
    @IBOutlet weak var calciumContent: UILabel!
    @IBOutlet weak var ironContent: UILabel!
    @IBOutlet weak var darkenView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkenView.backgroundColor = .black
        darkenView.alpha = 0.5
        loadObj()
        
        fruitDetailImage.image = UIImage(named: "\(fruitID!)")
        fruitDetailText.text = fruitArray?[fruitID!].fruitDesc
        servingPortion.text = "\(fruitArray![fruitID!].servingPortion)"
        caloriesContent.text = "Calories \(fruitArray?[fruitID!].calContent ?? 0) cal"
        totalFat.text = "Total Fat \(fruitArray?[fruitID!].totalFat ?? 0)g"
        sodContent.text = "Sodium \(fruitArray?[fruitID!].sodiumContent ?? 0)mg"
        carbContent.text = "Carbohydrate \(fruitArray?[fruitID!].carboContent ?? 0)g"
        sugarContent.text = "Sugar \(fruitArray?[fruitID!].sugarContent ?? 0)g"
        proteinContent.text = "Protein \(fruitArray?[fruitID!].vitaminAContent ?? 0)% DV"
        vitaminAContent.text = "Vitamin A \(fruitArray?[fruitID!].vitaminCContent ?? 0)% DV"
        vitaminCContent.text = "Vitamin C \(fruitArray?[fruitID!].totalFat ?? 0)% DV"
        calciumContent.text = "Calcium \(fruitArray?[fruitID!].totalFat ?? 0)% DV"
    }
    
    func loadObj () {
        fruitArray = realm.objects(Fruit.self)
        userArray = realm.objects(User.self)
    }
}
