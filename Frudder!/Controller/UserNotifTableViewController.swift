//
//  UserNotifTableViewController.swift
//  Frudder!
//
//  Created by Thomas Pratama Putra on 27/04/19.
//  Copyright © 2019 NA. All rights reserved.
//

import UIKit

class UserNotifTableViewController: UITableViewController {
    
    let encoder = PropertyListEncoder()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("UserNotification.plist")
    
    var arrayOfLOV: [String] = ["Every 3 hours", "Every 5 hours", "Every 7 hours"]
    
    var notifItem1 = NotifItem()
    var notifItem2 = NotifItem()
    var notifItem3 = NotifItem()
    var notifArray = [NotifItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* notifItem1.name = arrayOfLOV[0]
        notifItem1.isCheck = false
        notifItem1.timeInterval = 3
        
        notifItem2.name = arrayOfLOV[1]
        notifItem2.isCheck = false
        notifItem2.timeInterval = 5
        
        notifItem3.name = arrayOfLOV[2]
        notifItem3.isCheck = false
        notifItem3.timeInterval = 7
        
        notifArray.append(notifItem1)
        notifArray.append(notifItem2)
        notifArray.append(notifItem3)
        
        writeToPlist(param: notifArray) */
        
    }
    
    /* func writeToPlist(param: [NotifItem]) {
        do{
            let data = try encoder.encode(param)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item w/ error: \(error)")
        }
    } */

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath)
        cell.textLabel?.text = arrayOfLOV[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayOfLOV.count
    }

}
