//
//  Issue.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/6.
//

import Foundation

struct Issue : Codable {
    var itemList: [VideoCardItem] = []
    var nextPageUrl: String?
}
