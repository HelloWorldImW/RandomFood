//
//  AppDelegate.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/25.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit

let ZHScreenWidth = UIScreen.main.bounds.size.width
let ZHScreenHeight = UIScreen.main.bounds.size.height

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: ZHScreenWidth, height: ZHScreenHeight))
        
        let homeVC = ZHChooseFoodController()
        window?.rootViewController = homeVC
        window?.makeKeyAndVisible()

        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}

