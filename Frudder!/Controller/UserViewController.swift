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
    
    //MARK : - Declare variable(s) here
    
    //TODO: - Realm declaration
    let realm = try! Realm()
    
    //TODO: - User default plist declaration (for user configurations)
    let userDefault = UserDefaults.standard
    
    var fruitArray: Results<Fruit>?
    var userArray: Results<User>?

    @IBOutlet weak var reminderTableView: UITableView!
    @IBOutlet weak var welcomeUserText: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .orange
        
        //Add dummy fruit func.
        /* let fruit = Fruit()
        fruit.fruitID = 0
        fruit.fruitName = "Apple"
        fruit.funFacts = "High source of dietary fiber"
        fruit.glucoseContent = 25
        fruit.carboContent = 34
        fruit.calContent = 130
        fruit.vitaminContent = "Vitamin C, Vitamin A"
        
        let fruit2 = Fruit()
        fruit2.fruitID = 1
        fruit2.fruitName = "Guava"
        fruit2.funFacts = "Rich of vitamin C, high source of dietary fiber"
        fruit2.glucoseContent = 8
        fruit2.carboContent = 13
        fruit2.calContent = 60
        fruit2.vitaminContent = "Vitamin C, Vitamin A"
        
        let fruit3 = Fruit()
        fruit3.fruitID = 2
        fruit3.fruitName = "Banana"
        fruit3.funFacts = "High source of dietary fiber"
        fruit3.glucoseContent = 25
        fruit3.carboContent = 34
        fruit3.calContent = 130
        fruit3.vitaminContent = "Vitamin C, Vitamin A"
        
        let fruit4 = Fruit()
        fruit4.fruitID = 3
        fruit4.fruitName = "Orange"
        fruit4.funFacts = "Rich of vitamin C, high source of dietary fiber"
        fruit4.glucoseContent = 8
        fruit4.carboContent = 13
        fruit4.calContent = 60
        fruit4.vitaminContent = "Vitamin C, Vitamin A"
        
        let fruit5 = Fruit()
        fruit5.fruitID = 4
        fruit5.fruitName = "Soursop"
        fruit5.funFacts = "High source of dietary fiber"
        fruit5.glucoseContent = 25
        fruit5.carboContent = 34
        fruit5.calContent = 130
        fruit5.vitaminContent = "Vitamin C, Vitamin A"
        
        let fruit6 = Fruit()
        fruit6.fruitID = 5
        fruit6.fruitName = "Mangosteen"
        fruit6.funFacts = "Rich of vitamin C, high source of dietary fiber"
        fruit6.glucoseContent = 8
        fruit6.carboContent = 13
        fruit6.calContent = 60
        fruit6.vitaminContent = "Vitamin C, Vitamin A"
        
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
        
        do{
            try realm.write {
                realm.add(fruit6)
            }
        } catch {
            print("Error writing obj. w/ error message: \(error)")
        } */
        
        /* let user = User()
        user.fruitIDtoEat = 0
        user.stackDate = Date()
        user.quantityToEat = 3
        saveObj(object: user) */
        
        
        //TODO: - loadObj from local database
        loadObj()
        
        //MARK: - Load tableView custom cell
        reminderTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        //MARK: - userDefault line of code(s)
        //userDefault.set(Date(), forKey: "userLastAccessed")
        
        if !Calendar.current.isDateInToday(userDefault.object(forKey: "userLastAccessed") as! Date) {
            userDefault.set(Date(), forKey: "userLastAccessed")
        }
        else {
            //TODO: - Reset user fruit to eat quantities to zero
            //print(userDefault.object(forKey: "userLastAccessed"))
        }
        
        //TODO: - Add user to .plist using user default
        if let userName = userDefault.string(forKey: "userName") {
            welcomeUserText.textColor = .white
            welcomeUserText.text = "Hi, \(userName)!"
        }
        else {
            welcomeUserText.textColor = .white
            welcomeUserText.text = "Hi, Wilbert!"
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToAddFruit", sender: self)
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
    
    override func viewDidAppear(_ animated: Bool) {
        reminderTableView.reloadData()
    }
    
    //MARK : - Prepare for segue method(s)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    //MARK : - Notification func.
    func notificationAlert () {
        
        //Notify the notification center
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (isSuccess, error) in
            if isSuccess == true {
                print("Success")
            }
            else {
                print(error!)
            }
        }
        
        //Creating the notification content
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "This is a test notification"
        notificationContent.body = "This is it"
        
        //Creating trigger for the notification
        //TODO: - Change the timeTrigger to user preferences interval
        let timeTrigger = Date().addingTimeInterval(20)
        
        let timeComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: timeTrigger)
        
        let notificationTrigger = UNCalendarNotificationTrigger.init(dateMatching: timeComponents, repeats: false)
        
        //Making the notification request
        let uuID = UUID().uuidString
        let notificationRequest = UNNotificationRequest(identifier: uuID, content: notificationContent, trigger: notificationTrigger)
        
        //Registering the notification request
        notificationCenter.add(notificationRequest) { (error) in
        }
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
        cell.cellImage.layer.cornerRadius = 17
        cell.cellImage.clipsToBounds = true
        cell.cellImage.image = UIImage(named: "\(fruitArray?[(userArray![indexPath.row].fruitIDtoEat)].fruitID ?? 0)")
        cell.cellTitle.text = fruitArray?[(userArray![indexPath.row].fruitIDtoEat)].fruitName
        cell.cellDescription.text = userArray?[indexPath.row].quantityToEat.description
        return cell
    }
    
    //Swipe action func.
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let isDone = isCompleted(at: indexPath)
        return UISwipeActionsConfiguration(actions: [isDone])
    } 
    
    func isCompleted (at indexPath: IndexPath) -> UIContextualAction {
        let checkData = userArray?[indexPath.row]
        let action = UIContextualAction(style: .destructive, title: "Completed") { (action, view, completion) in
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
        //action.image = #imageLiteral(resourceName: "icon-checkmark")
        action.backgroundColor = #colorLiteral(red: 0, green: 0.8883596063, blue: 0, alpha: 1)
        return action
    }
    
}

//MARK : - UITableView delegate method(s)
extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
