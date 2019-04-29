//
//  UserNotifTableViewController.swift
//  Frudder!
//
//  Created by Thomas Pratama Putra on 27/04/19.
//  Copyright © 2019 NA. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD

class UserNotifTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("UserNotification.plist")
    
    var notifArray = [NotifItem]()
    
    var selectedIndex : Int = 0

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadPlist()
        
        self.navigationItem.largeTitleDisplayMode = .always
        tableView.tableFooterView = UIView()
        tableView.allowsMultipleSelection = false
        
        if notifArray.count == 0 {
            generateDummyConfigurations()
        }
        
        for i in 0...3 {
            if notifArray[i].isCheck == true {
                selectedIndex = i
            }
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        for i in 0...notifArray.count - 1 {
            if notifArray[i].isCheck == true {
                if notifArray[i].flagFire == true {
                    notificationAlert(hour: (notifArray[i].timeInterval))
                }
            }
            
            self.navigationItem.hidesBackButton = false
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
    
    func writeToPlist(param: [NotifItem]) {
       let encoder = PropertyListEncoder()
     
        do{
            let data = try encoder.encode(param)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item w/ error: \(error)")
        }
    }
    
    func notificationAlert(hour: Int) {
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
        notificationContent.title = "Have you eat any fruid today?"
        notificationContent.body = "A little reminder to eat your favorite healthy fruid."
        notificationContent.badge = 1
        
        //Creating trigger for the notification
        //TODO: - Change the timeTrigger to user preferences interval
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(hour) * 3600, repeats: true)
        
        //Making the notification request
        let uuID = UUID().uuidString
        let notificationRequest = UNNotificationRequest(identifier: uuID, content: notificationContent, trigger: timeTrigger)
        
        //Registering the notification request
        notificationCenter.add(notificationRequest) { (error) in
            print("\(String(describing: error))")
        }
    }
    
    func generateDummyConfigurations () {
        var arrayOfLOV: [String] = ["Remind me every 3 hours please!", "Umm... every 5 hours, I think?", "Meh. 7 hours please.", "Just turn it off already!"]
        
        let notifItem1 = NotifItem()
        let notifItem2 = NotifItem()
        let notifItem3 = NotifItem()
        let notifItem4 = NotifItem()
        
        notifItem1.name = arrayOfLOV[0]
        notifItem1.isCheck = true
        notifItem1.timeInterval = 3
        notifItem1.flagFire = true
        
    
        notifItem2.name = arrayOfLOV[1]
        notifItem2.isCheck = false
        notifItem2.timeInterval = 5
        notifItem2.flagFire = true
    
        notifItem3.name = arrayOfLOV[2]
        notifItem3.isCheck = false
        notifItem3.timeInterval = 7
        notifItem3.flagFire = true
        
        notifItem4.name = arrayOfLOV[3]
        notifItem4.isCheck = false
        notifItem4.timeInterval = 2000
        notifItem4.flagFire = false
    
        notifArray.append(notifItem1)
        notifArray.append(notifItem2)
        notifArray.append(notifItem3)
        notifArray.append(notifItem4)
        
        writeToPlist(param: notifArray)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath)
        cell.textLabel?.text = notifArray[indexPath.row].name
        
        if notifArray[indexPath.row].isCheck {
            cell.accessoryType = .checkmark
        }
        
        if indexPath.row == selectedIndex {
            cell.accessoryType = .checkmark
            notifArray[indexPath.row].isCheck  = true
            writeToPlist(param: notifArray)
        } else {
            cell.accessoryType = .none
            notifArray[indexPath.row].isCheck  = false
            writeToPlist(param: notifArray)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.navigationItem.hidesBackButton = true
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.tintColor = .orange
        return notifArray.count
    }
}
