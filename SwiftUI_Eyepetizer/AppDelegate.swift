//
//  AppDelegate.swift
//  SwiftUI_Eyepetizer
//
//  Created for Bugly Pro initialization
//

import UIKit
import BuglyPro

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configBugly()
        return true
    }

    private func configBugly() {
        // App ID 和 App Key 在 Bugly 专业版控制台的「产品配置」里可以找到
        let config = BuglyConfig(appId: "YOUR_APP_ID", appKey: "YOUR_APP_KEY")
        config.serverHostType = .buglyPro
        Bugly.start(with: config)
    }
}
