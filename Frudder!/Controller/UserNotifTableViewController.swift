//
//  UserNotifTableViewController.swift
//  Frudder!
//
//  Created by Thomas Pratama Putra on 27/04/19.
//  Copyright © 2019 NA. All rights reserved.
//

import UIKit

class UserNotifTableViewController: UITableViewController {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("UserNotification.plist")
    
    var notifArray = [NotifItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPlist()
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        
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
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath)
        cell.textLabel?.text = notifArray[indexPath.row].name
        cell.accessoryType = notifArray[indexPath.row].isCheck ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        notifArray[indexPath.row].isCheck = !notifArray[indexPath.row].isCheck
        writeToPlist(param: notifArray)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifArray.count
    }

}
