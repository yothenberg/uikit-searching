//
//  AppDelegate.swift
//  Searching
//
//  Created by Mark Wright on 12/2/18.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let menuController = MenuTableViewController()
        let navController = UINavigationController(rootViewController: menuController)
        self.window = UIWindow()
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

