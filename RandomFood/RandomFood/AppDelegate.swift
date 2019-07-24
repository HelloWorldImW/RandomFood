//
//  AppDelegate.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/25.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: ZHScreenWidth, height: ZHScreenHeight))
        let homeVC = ZHHomeViewController()
        window?.rootViewController = homeVC
        window?.makeKeyAndVisible()
        /// 配置第三方库
        configThirdLib()
        return true
    }
    
    func showScreenAd() {
//        manager = AdSpreadScreenManager.manager(withAdSpreadScreenKey: "SDK20181227120814372t7f1vq4n2ehu", with: self) as? AdSpreadScreenManager
//        manager?.requestAdSpreadScreenView(window?.rootViewController)
    }
    
    private func configThirdLib() {
        /// 高德地图
        AMapServices.shared().apiKey = "3f8c688ca34735a2eda4332699e0ca82"
        /// Bugly
        Bugly.start(withAppId: "2e9ef610ad")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}

