//
//  AppDelegate.swift
//  LXTabBar
//
//  Created by admin on 2018/8/1.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let tempWindow = UIWindow()
        tempWindow.frame = UIScreen.main.bounds
        tempWindow.backgroundColor = UIColor.white
        window = tempWindow
        
        let tabVC = LXTabBarController()
        
        let messageVC = LXMessageController()
        let messageNav = UINavigationController(rootViewController: messageVC)
        let message = LXMessageItem()
        message.title = "消息"
        tabVC.addController(messageNav, item: message)
        
        let contactVC = LXContactController()
        let contactNav = UINavigationController(rootViewController: contactVC)
        let contact = LXContactItem()
        contact.title = "联系人"
        tabVC.addController(contactNav, item: contact)
        
        let lookVC = LXLookController()
        let lookNav = UINavigationController(rootViewController: lookVC)
        let look = LXLookItem()
        look.title = "看点"
        tabVC.addController(lookNav, item: look)
        
        let timeVC = LXTimeLineController()
        let timeNav = UINavigationController(rootViewController: timeVC)
        let time = LXTimeLineItem()
        time.title = "动态"
        tabVC.addController(timeNav, item: time)
        
        tempWindow.rootViewController = tabVC
        tempWindow.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

