//
//  DiscoverViewModel.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import Foundation

class DiscoverViewModel : ObservableObject {
    @Published var selectedTabIndex = 0
    
    func setSelectedTabIndex(index: Int) {
        selectedTabIndex = index
    }
}
