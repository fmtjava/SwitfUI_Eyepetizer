//
//  ChatResponse.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2026/2/18.
//

import Foundation

struct ChatResponse: Codable {
    var code: Int
    var message: String
    var choices: [Choice]
}

struct Choice : Codable{
    var message: Message
}
