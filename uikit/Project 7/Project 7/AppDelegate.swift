//
//  AppDelegate.swift
//  Project 7
//
//  Created by Clément Villanueva on 10/07/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let tabBarController = window?.rootViewController as? UITabBarController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
            tabBarController.viewControllers?.append(vc)
        }

        return true
    }

}

