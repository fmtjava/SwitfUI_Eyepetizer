//
//  HotTabViewModel.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import Foundation

class HotTabViewModel : ObservableObject {
    
    @Published var videoCardList: [VideoCardItem] = []
    @Published var errorMessage: String? = nil
    @Published var isRefreshing: Bool = false
    
    func fetchTabData(url: String) async {
        do {
            guard let url = URL(string: url) else {
                self.errorMessage = NSLocalizedString("invalid_url", comment: "")
                return
            }
            
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 10.0
            configuration.timeoutIntervalForResource = 10.0
            
            let session = URLSession(configuration: configuration)
            let (data, _) = try await session.data(from: url)
            let issue = try JSONDecoder().decode(Issue.self, from: data)
            
            await MainActor.run {
                self.videoCardList = issue.itemList
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
}
