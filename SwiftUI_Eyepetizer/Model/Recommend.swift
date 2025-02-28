//
//  Recommend.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/16.
//

import Foundation

struct Recommend : Codable {
    var itemList: [RecommendItem] = []
    var nextPageUrl: String?
}

struct RecommendItem : Codable {
    var type : String
    var data: RecommendItemData
    var id: Int
}

struct RecommendItemData : Codable {
    var content: VideoCardItem?
}
