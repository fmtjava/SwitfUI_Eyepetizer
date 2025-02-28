//
//  WatchRecordViewModel.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import Foundation

class WatchRecordViewModel : ObservableObject {
    
    let watchVideoListKey : String = "watch_video_list_key"
    
    @Published var watchVideoItemList: [VideoCardItemData] = [] {
        didSet {
            saveItem()
        }
    }
    
    init() {
        guard let data = UserDefaults.standard.data(forKey: watchVideoListKey),
              let watchVideoItems = try? JSONDecoder().decode([VideoCardItemData].self, from: data) else {
            return
        }
        self.watchVideoItemList = watchVideoItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        self.watchVideoItemList.remove(atOffsets: indexSet)
    }
    
    func saveItem() {
        if let data = try? JSONEncoder().encode(watchVideoItemList) {
            UserDefaults.standard.setValue(data, forKey: watchVideoListKey)
        }
    }
    
}
