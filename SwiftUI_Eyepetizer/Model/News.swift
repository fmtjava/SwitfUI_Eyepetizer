//
//  News.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/15.
//

import Foundation

struct News : Codable {
    var itemList: [NewsItem] = []
    var nextPageUrl: String?
}

struct NewsItem : Codable {
    var type: String
    var data: NewsItemData
}

struct NewsItemData : Codable {
    var id: Int
    var text: String?
    var backgroundImage: String?
    var actionUrl: String?
    var titleList: [String]?
}
