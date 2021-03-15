//
//  AppDelegate.swift
//  TabsScreen
//
//  Created by Mohamed Korany on 3/15/21.
//  Copyright © 2021 Mohamed Korany. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    window = UIWindow()
    window?.makeKeyAndVisible()
    let firstViewController = FirstViewController()
    firstViewController.tabBarItem = UITabBarItem(title: "My Account")

    let secondViewController = SecondViewController()
    secondViewController.tabBarItem = UITabBarItem(title: "Second",image: nil,selectedImage: nil)
    
    let tabController = PageViewController()
    tabController.applyDefaultStyle()
    tabController.controllers = [firstViewController, secondViewController]
    window?.rootViewController = tabController
    
    
    return true
  }

}


// MARK: - UITabBarItem+Heleprs
//
extension UITabBarItem {
  
  /// Convenience init using title only, settings image and tag with null values
  ///
  convenience init(title: String?) {
    self.init(title: title, image: nil, tag: .zero)
  }
}
