//
//  BottomTabItem.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import Foundation

struct BottomTabItem {
    let titleKey: String
    let normalIcon: String
    let selectIcon: String
    
    var localizedTitle: String {
        return NSLocalizedString(titleKey, comment: "")
    }
}
