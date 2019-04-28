//
//  UserViewController.swift
//  Frudder!
//
//  Created by Thomas Pratama Putra on 23/04/19.
//  Copyright © 2019 NA. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework
import UserNotifications

class UserViewController: UIViewController {
    
    //TODO: - Realm declaration
    let realm = try! Realm()
    
    //TODO: - User default plist declaration (for user configurations)
    let userDefault = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("UserNotification.plist")
    
    //MARK : - Declare variable(s) here
    var fruitArray: Results<Fruit>?
    var userArray: Results<User>?
    
    var notifArray = [NotifItem]()
    
    var userUserName: String = String()

    @IBOutlet weak var reminderTableView: UITableView!
    @IBOutlet weak var welcomeUserText: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var buttonFrame: UIView!
    @IBOutlet weak var darkenView: UIView!
    @IBOutlet weak var configButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .orange
        darkenView.backgroundColor = .black
        darkenView.alpha = 0.2
        reminderTableView.tableFooterView = UIView()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .never
        
        //Hiding config. button for ease conv.
        configButtonOutlet.isHidden = true
        
        //TODO: - loadObj from local database
        loadObj()
        
        if fruitArray?.count == 0 {
            addDummyFruit()
        }
        
        if let userName = userDefault.string(forKey: "userName") {
            welcomeUserText.text = "Hi, \(userName)!"
            welcomeUserText.textColor = .white
        }
        else {
//            addUserName()
            welcomeUserText.text = "Hi, Wilbert!"
            welcomeUserText.textColor = .white
        }
        
        //MARK: - Load tableView custom cell
        reminderTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        //MARK: - userDefault line of code(s)
        if userDefault.object(forKey: "userLastAccessed") == nil {
            userDefault.set(Date(), forKey: "userLastAccessed")
        }
        
        //TODO: - Add user to .plist using user default

        buttonFrame.layer.cornerRadius = buttonFrame.frame.size.width / 2
        buttonFrame.backgroundColor = .orange
        buttonOutlet.adjustsImageWhenHighlighted = false
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToAddFruit", sender: self)
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToReminder", sender: self)
    }
    
    @IBAction func configButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToConfigurations", sender: self)
    }
    
    func loadObj () {
        fruitArray = realm.objects(Fruit.self)
        userArray = realm.objects(User.self)
        reminderTableView.reloadData()
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
    
    func loadPlist () {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                notifArray = try decoder.decode([NotifItem].self, from: data)
            } catch {
                print("Error decoding plist w/ error message: \(error)")
            }
        }
    }
    
    //MARK: - Add new user if empty
    func addUserName () {
        var tempText: UITextField?
        
        let alert = UIAlertController.init(title: "Welcome", message: "Insert user name here", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Continue", style: .default) { (alertAction) in
            self.userDefault.setValue(tempText!.text!, forKey: "userName")
        }
        
        alert.addTextField { (textField) in
            tempText = textField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func addDummyFruit() {
        let fruit = Fruit()
        fruit.fruitID = 0
        fruit.fruitName = "Apple"
        fruit.funFacts = "Did you know? about 2,500 known varieties of apples are grown in the United States. More than 7,500 are grown worldwide."
        fruit.fruitDesc = "Refrigerate apple(s) in plastic bag away from strong-odored foods. Consume within 3 weeks."
        fruit.totalFat = 0
        fruit.sodiumContent = 80
        fruit.sugarContent = 25
        fruit.carboContent = 34
        fruit.calContent = 130
        fruit.vitaminAContent = 2
        fruit.vitaminCContent = 8
        fruit.calciumContent = 2
        fruit.ironContent = 2
        fruit.servingPortion = "1 Large Apple (242g)"
        
        let fruit2 = Fruit()
        fruit2.fruitID = 1
        fruit2.fruitName = "Guava"
        fruit2.funFacts = "Eat everything, including the seeds."
        fruit2.fruitDesc = "Ripen guava(s) at room temperature until they give to gentle pressure. Refrigerate guava(s) immediately, and use within 4 days."
        fruit2.totalFat = 1
        fruit2.sodiumContent = 0
        fruit2.sugarContent = 8
        fruit2.carboContent = 13
        fruit2.calContent = 60
        fruit2.vitaminAContent = 10
        fruit2.vitaminCContent = 340
        fruit2.calciumContent = 2
        fruit2.ironContent = 2
        fruit2.servingPortion = "1 Fruit (90g)"
        
        let fruit3 = Fruit()
        fruit3.fruitID = 2
        fruit3.fruitName = "Banana"
        fruit3.funFacts = "Banana trees are not trees. The banana plant is a giant herb."
        fruit3.fruitDesc = "Store unripe banana(s) at room temperature. Store ripe banana(s) in refrigerator for up to two weeks; skin may turn black."
        fruit3.totalFat = 0
        fruit3.sodiumContent = 0
        fruit3.sugarContent = 19
        fruit3.carboContent = 30
        fruit3.calContent = 100
        fruit3.vitaminAContent = 2
        fruit3.vitaminCContent = 15
        fruit3.calciumContent = 0
        fruit3.ironContent = 2
        fruit3.servingPortion = "1 Medium Banana (126g)"
        
        let fruit4 = Fruit()
        fruit4.fruitID = 3
        fruit4.fruitName = "Orange"
        fruit4.funFacts = "BREAKING NEWS! The proper name for an orange seed is a pip. Would you look at that."
        fruit4.fruitDesc = "Store orange(s) at room temperature for one to two days, refrigerate for one to two weeks."
        fruit4.totalFat = 0
        fruit4.sodiumContent = 0
        fruit4.sugarContent = 9
        fruit4.carboContent = 19
        fruit4.calContent = 80
        fruit4.vitaminAContent = 2
        fruit4.vitaminCContent = 130
        fruit4.calciumContent = 6
        fruit4.ironContent = 0
        fruit4.servingPortion = "1 Medium Orange (154g)"
        
        let fruit5 = Fruit()
        fruit5.fruitID = 4
        fruit5.fruitName = "Strawberry"
        fruit5.funFacts = "LoOkie LOOKIE! On average, there are 200 tiny seeds on every strawberry. Start counting guys!"
        fruit5.fruitDesc = "Do not wash strawberry until they are ready to eat. Store in refrigerator for one to three days."
        fruit5.totalFat = 0
        fruit5.sodiumContent = 0
        fruit5.sugarContent = 8
        fruit5.carboContent = 11
        fruit5.calContent = 50
        fruit5.vitaminAContent = 0
        fruit5.vitaminCContent = 160
        fruit5.calciumContent = 2
        fruit5.ironContent = 2
        fruit5.servingPortion = "2 Medium Strawberries (67g)"
        
        do{
            try realm.write {
                realm.add(fruit)
            }
        } catch {
            print("Error writing obj. w/ error message: \(error)")
        }
        
        do{
            try realm.write {
                realm.add(fruit2)
            }
        } catch {
            print("Error writing obj. w/ error message: \(error)")
        }
        
        do{
            try realm.write {
                realm.add(fruit3)
            }
        } catch {
            print("Error writing obj. w/ error message: \(error)")
        }
        
        do{
            try realm.write {
                realm.add(fruit4)
            }
        } catch {
            print("Error writing obj. w/ error message: \(error)")
        }
        
        do{
            try realm.write {
                realm.add(fruit5)
            }
        } catch {
            print("Error writing obj. w/ error message: \(error)")
        }
        
        let user = User()
        user.fruitIDtoEat = 0
        user.stackDate = Date()
        user.quantityToEat = 3
        saveObj(object: user)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        reminderTableView.reloadData()
    }
}

//MARK : - UITableView dataSource method(s)
extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .clear
        return userArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 10
        cell.cellImage.layer.cornerRadius = cell.cellImage.frame.size.width / 2
        cell.cellImage.clipsToBounds = true
        cell.cellImage.image = UIImage(named: "\(fruitArray?[(userArray![indexPath.row].fruitIDtoEat)].fruitID ?? 0)")
        cell.cellTitle.text = "\(userArray![indexPath.row].quantityToEat.description) \(fruitArray![(userArray![indexPath.row].fruitIDtoEat)].fruitName)"
        let dateCounterValue = dateCounter(date: userArray![indexPath.row].stackDate!)
        cell.cellDescription.text = "Fruid added \(dateCounterValue)"
        return cell
    }
    
    //Swipe action func.
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let isDone = isCompleted(at: indexPath)
        return UISwipeActionsConfiguration(actions: [isDone])
    } 
    
    func isCompleted (at indexPath: IndexPath) -> UIContextualAction {
        let checkData = userArray?[indexPath.row]
        let action = UIContextualAction(style: .destructive, title: "Yum!") { (action, view, completion) in
            do {
                try self.realm.write {
                    self.realm.delete(checkData!)
                    self.userArray = self.userArray?.sorted(byKeyPath: "stackDate", ascending: true)
                    self.reminderTableView.reloadData()
                }
            } catch {
                print("Error deleting object(s)")
            }
            
            completion(true)
        }
        action.backgroundColor = UIColor.flatMint()
        return action
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let isNotDone = isDeleted(at: indexPath)
        return UISwipeActionsConfiguration(actions: [isNotDone])
    }
    
    func isDeleted (at indexPath: IndexPath) -> UIContextualAction {
        let checkData = userArray?[indexPath.row]
        let action = UIContextualAction(style: .destructive, title: "Yuck!") { (action, view, completion) in
            do {
                try self.realm.write {
                    self.realm.delete(checkData!)
                    self.userArray = self.userArray?.sorted(byKeyPath: "stackDate", ascending: true)
                    self.reminderTableView.reloadData()
                }
            } catch {
                print("Error deleting object(s)")
            }
            
            completion(true)
        }
        action.backgroundColor = UIColor.flatRed()
        return action
    }
    
    func dateCounter (date: Date) -> String {
        
        var hourString = ""
        var fullTimestampString = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a"
        
        let dateFormatterPrintFull = DateFormatter()
        dateFormatterPrintFull.dateFormat = "E, dd MMM yyy h:mm a"

        hourString = "\(dateFormatterPrint.string(from: date))"
        fullTimestampString = "\(dateFormatterPrintFull.string(from: date))"
        
        
        let calendarCurr = Calendar.current
        
        if calendarCurr.isDateInYesterday (date) {
            return "yesterday at \(hourString)"
        }
        else if calendarCurr.isDateInToday (date) {
            return  "today at \(hourString)"
            
        }
        else {
            let startOfNow = calendarCurr.startOfDay(for: Date())
            let startOfTimeStamp = calendarCurr.startOfDay(for: date)
            let components = calendarCurr.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
            let day = components.day!
            if day < 1 {
                return "\(-day) days ago on \(fullTimestampString)" }
            else {
                return( "In \(day) days  on \(fullTimestampString)" )}
        }
    }
}

//MARK : - UITableView delegate method(s)
extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
