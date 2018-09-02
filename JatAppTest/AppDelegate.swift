//
//  AppDelegate.swift
//  JatAppTest
//
//  Created by Vitaly Plivachuk on 8/30/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let itemsVC = VPTextItemsViewControlller()
        let navc = UINavigationController(rootViewController: itemsVC)
        window?.rootViewController = navc
        window?.makeKeyAndVisible()
        
        
//        let vc = UINib(nibName: "VPLoginViewController", bundle: nil).instantiate(withOwner: VPLoginViewController.self)
        
        // Override point for customization after application launch.
        return true
    }
}

