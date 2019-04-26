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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fruitDetailImage.image = UIImage(named: "\(fruitID!)")
        // Do any additional setup after loading the view.
    }
    
    func loadObj () {
        fruitArray = realm.objects(Fruit.self)
        userArray = realm.objects(User.self)
    }
}
