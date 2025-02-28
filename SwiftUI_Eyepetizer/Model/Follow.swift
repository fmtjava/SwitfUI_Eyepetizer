//
//  Follow.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/15.
//

import Foundation

struct Follow : Codable {
    var itemList: [VideoCardItem] = []
    var nextPageUrl: String?
}
