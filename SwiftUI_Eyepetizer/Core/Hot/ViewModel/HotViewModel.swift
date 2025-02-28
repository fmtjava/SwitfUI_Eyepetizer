//
//  HotViewModel.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import Foundation

class HotViewModel : ObservableObject {
    @Published var tabList: [Tab] = []
    @Published var selectedTabIndex = 0
    @Published var isLoading = false
    @Published var isError: Bool = false
    @Published var errorMessage: String? = nil
    
    func setSelectedTabIndex(index: Int) {
        selectedTabIndex = index
    }
    
    func fetchHotTabList() async {
        do {
            await MainActor.run {
                self.isLoading = true
            }
            guard let url = URL(string: ApiService.rankList.url) else {
                self.errorMessage = NSLocalizedString("invalid_url", comment: "")
                self.isLoading = false
                self.isError = true
                return
            }
            
            let (data, _) = try await session.data(from: url)
            let tabListInfo = try JSONDecoder().decode(TabListInfo.self, from: data)
            
            await MainActor.run {
                self.tabList = tabListInfo.tabInfo.tabList
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
}
