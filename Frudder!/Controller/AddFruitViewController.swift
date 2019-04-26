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
    
    func loadObj() {
        fruitArray = realm.objects(Fruit.self)
        fruitTableView.reloadData()
    }
    
    func saveObj(object: Fruit) {
        do{
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error writing obj. w/ error message: \(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToAddQuantity" {
        
            let destinationVC = segue.destination as! AddQuantityViewController
            
            if let indexPath = fruitTableView.indexPathForSelectedRow {
                destinationVC.tempFruitID = indexPath.row
            }
        }
        
        else if segue.identifier == "goToFruitInfo" {
            if let fruit = sender as? Fruit {
            
            let destinationVC = segue.destination as! FruitInfoViewController
                destinationVC.fruitID = fruit.fruitID
            }
        }
    }
}

//MARK : - UITableView dataSource method(s)
extension AddFruitViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return fruitArray?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fruitDetailCell", for: indexPath) as! FruitDetailTableViewCell
        cell.fruit = fruitArray?[indexPath.row]
        cell.backgroundColor = .clear
        cell.fruitImage.clipsToBounds = true
        cell.fruitTitle.text = fruitArray?[indexPath.row].fruitName
        cell.fruitTitle.textColor = .white
        cell.fruitDescription.text = fruitArray?[indexPath.row].funFacts
        cell.fruitDescription.textColor = .black
        cell.fruitImage.image = UIImage(named: "\(fruitArray?[indexPath.row].fruitID ?? 1)")
        cell.fruitImage.backgroundColor = .black
        cell.darkenView.backgroundColor = .black
        cell.darkenView.alpha = 0.2
        cell.delegate = self
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

//MARK: - UISearchBar delegate method(s)
extension AddFruitViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fruitArray = fruitArray?.filter("fruitName CONTAINS[cd] %@", searchBar.text!)
        fruitTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadObj()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

extension AddFruitViewController: infoButtonPressedDelegate {
    func infoButtonPressed(fruit: Fruit) {
        performSegue(withIdentifier: "goToFruitInfo", sender: fruit)
    }
}
