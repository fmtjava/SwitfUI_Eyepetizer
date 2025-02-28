//
//  VideoCardItem.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/6.
//

import Foundation

struct VideoCardItem : Codable {
    var type: String
    var data: VideoCardItemData?
}

struct VideoCardItemData : Codable {
    var id: Int?
    var dataType: String?
    var text: String?
    var description: String?
    var title: String?
    var category: String?
    var duration: Int?
    var playUrl: String?
    var width: Int?
    var height: Int?
    var urls: [String]?
    var consumption: Consumption?
    var owner: Owner?
    var header: Header?
    var author: Author?
    var cover: Cover?
    var itemList: [VideoCardItem]?
}

struct Header : Codable {
    var id: Int?
    var icon: String?
    var title: String?
    var description: String?
}

struct Author : Codable {
    var icon: String?
    var name: String?
    var description: String?
    var latestReleaseTime: Int64?
}

struct Cover : Codable {
    var feed: String
    var blurred: String?
    var detail: String
}

struct Owner : Codable {
    var avatar: String?
    var nickname: String?
}

struct Consumption : Codable {
    var collectionCount: Int
    var shareCount: Int
    var replyCount: Int
}
