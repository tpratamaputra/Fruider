//
//  AppDelegate.swift
//  Frudder!
//
//  Created by Thomas Pratama Putra on 23/04/19.
//  Copyright © 2019 NA. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("UserNotification.plist")
    
    var notifArray = [NotifItem]()
    
    //let userName = UserDefaults.standard.string(forKey: "userName")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        func writeToPlist(param: [NotifItem]) {
            let encoder = PropertyListEncoder()
            
            do{
                let data = try encoder.encode(param)
                try data.write(to: dataFilePath!)
            } catch {
                print("Error encoding item w/ error: \(error)")
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
        
        func generateDummyConfigurations () {
            var arrayOfLOV: [String] = ["Every 3 hours", "Every 5 hours", "Every 7 hours"]
            
            let notifItem1 = NotifItem()
            let notifItem2 = NotifItem()
            let notifItem3 = NotifItem()
            
            notifItem1.name = arrayOfLOV[0]
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
            
            writeToPlist(param: notifArray)
        }
        
        func notificationAlert(hour: Int) {
            //Notify the notification center
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (isSuccess, error) in
                if isSuccess == true {
                    print("Success")
                }
                else {
                    print(error ?? "Not generating for specific time interval")
                }
            }
            
            //Creating the notification content
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "Have you eat your fruit today?"
            notificationContent.body = "Check your fruid stack over here!"
            
            //Creating trigger for the notification
            //TODO: - Change the timeTrigger to user preferences interval
            let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(hour) * 3600, repeats: false)
            
            //Making the notification request
            let uuID = UUID().uuidString
            let notificationRequest = UNNotificationRequest(identifier: uuID, content: notificationContent, trigger: timeTrigger)
            
            //Registering the notification request
            notificationCenter.add(notificationRequest) { (error) in
            }
        }
        
        loadPlist()
        
        if notifArray.count == 0 {
            generateDummyConfigurations()
            print("generateSuccess")
        }
        
        for i in 0...notifArray.count - 1 {
            if notifArray[i].isCheck == true {
                notificationAlert(hour: (notifArray[i].timeInterval))
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
//        let realm = try! Realm()
//        print(realm.configuration.fileURL)

