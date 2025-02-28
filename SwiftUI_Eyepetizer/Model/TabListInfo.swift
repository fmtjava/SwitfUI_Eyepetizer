//
//  TabListInfo.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/9.
//

import Foundation

struct TabListInfo : Codable {
    var tabInfo: TabInfo
}

struct TabInfo : Codable {
    var tabList: [Tab]
}

struct Tab : Codable {
    var name: String
    var apiUrl:String
}
