//
//  UserViewController.swift
//  Frudder!
//
//  Created by Thomas Pratama Putra on 23/04/19.
//  Copyright © 2019 NA. All rights reserved.
//

//Add dummy fruit to database func.
/*let fruit = Fruit()
fruit.name = "Banana"
let fruit2 = Fruit()
fruit.name = "Mangosteen"
let fruit3 = Fruit()
fruit.name = "Jackfruit"
saveObj(object: fruit)
saveObj(object: fruit2)
saveObj(object: fruit3)*/


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
    
    var fruitArray : Results<Fruit>?

    @IBOutlet weak var reminderTableView: UITableView!
    @IBOutlet weak var welcomeUserText: UILabel!
    //@IBOutlet weak var welcomeReminderText: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //Add dummy fruit func.
        /*let fruit = Fruit()
        fruit.name = "Banana"
        let fruit2 = Fruit()
        fruit2.name = "Mangosteen"
        let fruit3 = Fruit()
        fruit3.name = "Jackfruit"
        saveObj(object: fruit)
        saveObj(object: fruit2)
        saveObj(object: fruit3)*/
        
        //TODO: - loadObj from local database
        loadObj()
        
        //welcomeReminderText.text = " "
        
        buttonOutlet.backgroundColor = UIColor.flatPowderBlue()
        
        //MARK: - Load tableView custom cell
        reminderTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        //MARK: - userDefault line of code(s)
        if !Calendar.current.isDateInToday(userDefault.object(forKey: "userLastAccessed") as! Date) {
            userDefault.set(Date(), forKey: "userLastAccessed")
        }
        else {
            //TODO: - Reset user fruit to eat quantities to zero
            //print(userDefault.object(forKey: "userLastAccessed"))
        }
        
        if let userName = userDefault.string(forKey: "userName") {
            welcomeUserText.text = "Hi, \(userName)!"
            welcomeUserText.textColor = .white
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
        reminderTableView.reloadData()
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
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell
        cell.backgroundColor = UIColor.flatOrange()
        cell.layer.cornerRadius = 10
        cell.cellImage.layer.cornerRadius = cell.cellImage.frame.size.width / 2
        cell.cellImage.clipsToBounds = true
        cell.cellImage.image = UIImage(named: "pineapple")
        cell.cellTitle.text = fruitArray?[indexPath.section].name
        cell.cellDescription.text = "\(fruitArray![indexPath.section].quantity)"
        return cell
    }
    
    //Swipe action func.
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let isDone = isCompleted(at: indexPath)
        return UISwipeActionsConfiguration(actions: [isDone])
    } 
    
    func isCompleted (at indexPath: IndexPath) -> UIContextualAction {
        let checkData = fruitArray?[indexPath.row]
        let action = UIContextualAction(style: .destructive, title: "Completed") { (action, view, completion) in
            do {
                try self.realm.write {
                    self.realm.delete(checkData!)
                }
            } catch {
                print("Error deleting object(s)")
            }
            self.reminderTableView.reloadData()
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "icon-checkmark")
        action.backgroundColor = .green
        return action
        
    }
    
}

//MARK : - UITableView delegate method(s)
extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fruitArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
}
