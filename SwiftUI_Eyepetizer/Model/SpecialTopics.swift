//
//  SpecialTopics.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/15.
//

import Foundation

struct SpecialTopics : Codable {
    var itemList: [Topic] = []
    var nextPageUrl: String?
}

struct Topic : Codable {
    var data: TopicData
}

struct TopicData : Codable {
    var id : Int
    var image: String
    var actionUrl: String
}
