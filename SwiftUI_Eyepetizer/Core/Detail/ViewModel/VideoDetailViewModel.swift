//
//  VideoDetailViewModel.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import Foundation

class VideoDetailViewModel : ObservableObject {
    @Published var relateVideoList : [VideoCardItem] = []
    @Published var isLoading = false
    @Published var isError: Bool = false
    @Published var errorMessage: String? = nil
    
    let watchVideoListKey: String = "watch_video_list_key"
    var watchVideoItemList: [VideoCardItemData] = []
    
    init() {
        guard let data = UserDefaults.standard.data(forKey: watchVideoListKey),
              let watchVideoItems = try? JSONDecoder().decode([VideoCardItemData].self, from: data) else {
            return
        }
        self.watchVideoItemList = watchVideoItems
    }
    
    func fetchtRelateVideoList(id: Int) async {
        do {
            await MainActor.run {
                self.isLoading = true
            }
            guard let url = URL(string: "\(ApiService.relatedList.url)?id=\(id)") else {
                self.errorMessage = NSLocalizedString("invalid_url", comment: "")
                self.isLoading = false
                self.isError = true
                return
            }
            
            let (data, _) = try await session.data(from: url)
            let issue = try JSONDecoder().decode(Issue.self, from: data)
            
            await MainActor.run {
                self.relateVideoList = issue.itemList
                self.isLoading = false
                self.isError = false
                self.errorMessage = nil
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isError = true
                self.isLoading = false
            }
        }
    }
    
    func saveWatchVideoItem(itemData: VideoCardItemData) {
        if !watchVideoItemList.contains(where: {$0.id == itemData.id}) {
            watchVideoItemList.append(itemData)
            if let jsonData = try? JSONEncoder().encode(watchVideoItemList) {
                UserDefaults.standard.setValue(jsonData, forKey: watchVideoListKey)
            }
        }
    }
}
