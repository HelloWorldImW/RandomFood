//
//  AppDelegate.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/25.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, AdSpreadScreenManagerDelegate {

    var window: UIWindow?
    var manager: AdSpreadScreenManager?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: ZHScreenWidth, height: ZHScreenHeight))
        
        let homeVC = ZHRandomController()
        let nav = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        /// 配置第三方库
        configThirdLib()
        
        manager = AdSpreadScreenManager.manager(withAdSpreadScreenKey: "SDK20181227120814372t7f1vq4n2ehu", with: self) as? AdSpreadScreenManager
        manager?.requestAdSpreadScreenView(window?.rootViewController)
        
        return true
    }
    
    func adSpreadScreenWindow() -> UIWindow! {
        return window
    }
     
    private func configThirdLib() {
        /// 高德地图
        AMapServices.shared().apiKey = "3f8c688ca34735a2eda4332699e0ca82"
        
        /// ADView广告
        let config = AdViewConfigStore.shared()
        config?.requestConfig(["SDK20181227120814372t7f1vq4n2ehu"], sdkType: AdViewSDKType_Banner)
        config?.requestConfig(["SDK20181227120814372t7f1vq4n2ehu"], sdkType: AdViewSDKType_Instl)
        config?.requestConfig(["SDK20181227120814372t7f1vq4n2ehu"], sdkType: AdViewSDKType_SpreadScreen)
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}

