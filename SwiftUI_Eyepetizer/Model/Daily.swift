//
//  Daily.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/6.
//

import Foundation

struct Daily : Codable {
    var issueList: [Issue]
    var nextPageUrl: String?
}
