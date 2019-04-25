//
//  AddFruitViewController.swift
//  Frudder!
//
//  Created by Thomas Pratama Putra on 23/04/19.
//  Copyright © 2019 NA. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class AddFruitViewController: UIViewController {
    
    let realm = try! Realm()
    
    var fruitArray : Results<Fruit>?
    
    @IBOutlet weak var fruitTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fruitTableView.register(UINib(nibName: "FruitDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "fruitDetailCell")
        loadObj()
    }
    
    func loadObj () {
        fruitArray = realm.objects(Fruit.self)
        fruitTableView.reloadData()
    }
    
    func saveObj (object: Fruit) {
        do{
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error writing obj. w/ error message: \(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let destinationVC = segue.destination as! AddQuantityViewController
    
        if let indexPath = fruitTableView.indexPathForSelectedRow {
            destinationVC.tempFruit = fruitArray![indexPath.row].name
        }
    }
}

//MARK : - UITableView dataSource method(s)
extension AddFruitViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .clear
        return fruitArray?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fruitDetailCell", for: indexPath) as! FruitDetailTableViewCell
        cell.backgroundColor = .clear
        cell.fruitImage.layer.cornerRadius = 17
        cell.fruitImage.clipsToBounds = true
        cell.fruitImage.image = UIImage(named: "strawberry")
        cell.fruitTitle.text = fruitArray?[indexPath.row].name
        cell.fruitImage.image =  #imageLiteral(resourceName: "strawberry")
        return cell
    }
}

//MARK : - UITableView delegate method(s)
extension AddFruitViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToAddQuantity", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
