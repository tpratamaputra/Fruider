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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        func defaultNotif () {
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
            notificationContent.title = "Have you eat any fruid today?"
            notificationContent.body = "A little reminder to eat your favorite healthy fruid."
            
            //Creating trigger for the notification
            //TODO: - Change the timeTrigger to user preferences interval
            let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(60), repeats: true)
            
            //Making the notification request
            let notificationRequest = UNNotificationRequest(identifier: "fruiderLocalNotification", content: notificationContent, trigger: timeTrigger)
            
            //Registering the notification request
            notificationCenter.add(notificationRequest) { (error) in
                print("\(String(describing: error))")
            }
            
            print("Successfuly set default notif. interval (3 hours)")
        }
        
        if UserDefaults.standard.object(forKey: "userLastAccessed") == nil {
            defaultNotif()
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

