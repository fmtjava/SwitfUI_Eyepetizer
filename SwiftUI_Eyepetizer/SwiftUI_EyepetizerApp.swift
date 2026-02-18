//
//  SwiftUI_EyepetizerApp.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import SwiftUI

@main
struct SwiftUI_EyepetizerApp: App {
    // 通过 @UIApplicationDelegateAdaptor(AppDelegate.self) 注入 AppDelegate，让 SwiftUI App 依然走系统启动流程
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
