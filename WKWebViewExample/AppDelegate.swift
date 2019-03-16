//
//  AppDelegate.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, JPUSHRegisterDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // APNS
        let userNotificationCenter:UNUserNotificationCenter = UNUserNotificationCenter.current()
        let authOptions:UNAuthorizationOptions = [UNAuthorizationOptions.alert, UNAuthorizationOptions.sound, UNAuthorizationOptions.badge]
        userNotificationCenter.requestAuthorization(options: authOptions, completionHandler: { granted, error in
            if granted {
                print("使用者同意了")
                userNotificationCenter.getNotificationSettings { settings in
                    if (settings.authorizationStatus == .authorized) {
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                    }
                }
            } else {
                print("使用者不同意")
            }
        })
        
        UNUserNotificationCenter.current().delegate = self
        
        // JiGuang
        let entity = JPUSHRegisterEntity()
        entity.types = NSInteger(UNAuthorizationOptions.alert.rawValue) |
            NSInteger(UNAuthorizationOptions.sound.rawValue) |
            NSInteger(UNAuthorizationOptions.badge.rawValue)
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        
        JPUSHService.setup(withOption: launchOptions, appKey: JPushKeys.appKey, channel: JPushKeys.channel, apsForProduction: true)
        
        
        return true
        
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        print("didRegisterForRemoteNotificationsWithDeviceToken")
        
        // JiGuang
        JPUSHService.registerDeviceToken(deviceToken)
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("didFailToRegisterForRemoteNotificationsWithError")
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
        print("didReceiveRemoteNotification")
        
        // JiGuang
        JPUSHService.handleRemoteNotification(userInfo)
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("didReceiveRemoteNotificationFetch")
        
        // JiGuang
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
        
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!,
                                 withCompletionHandler completionHandler: ((Int) -> Void)!) {
        
        print("jpushWillPresentNotification")
        print("\(notification)")
        // 在展示推送之前触发，可以在此替换推送内容，更改展示效果：内容、声音、角标
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        } else {
            //本地通知
        }
        
        //需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
        
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        
        print("jpushDidReceiveResponse")
        print("\(response)")
        // 在收到推送后触发，你原先写在 didReceiveRemoteNotification 方法里接收推送并处理相关逻辑的代码，现在需要在这个方法里也写一份
        
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        } else {
            //本地通知
        }
        
        //处理通知 跳到指定界面等等
//        let dataExample = userInfo["key"] as! String
//        let rootView = getRootViewController()
//        rootView.pushViewController(MessageViewController.init(type: 2), animated: true)
//        //角标至0
//        UIApplication.shared.applicationIconBadgeNumber = 0
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) { }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) { }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        print("userCenterWillPresentNotification")

        let presentOptions:UNNotificationPresentationOptions = [UNNotificationPresentationOptions.alert, UNNotificationPresentationOptions.sound, UNNotificationPresentationOptions.badge]

        completionHandler(presentOptions)

    }
    
    func createNotification(id:String, title:String, subTitle:String, body:String, badge:NSNumber?, delay:TimeInterval, completionHandler:((Error?) -> Void)?) {

        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subTitle
        content.body = body
        content.badge = badge
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: completionHandler)

    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {
        //角标至0
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) { }
}

