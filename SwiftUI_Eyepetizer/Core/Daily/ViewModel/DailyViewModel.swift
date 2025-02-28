//
//  DailyViewModel.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import Foundation

let BANNER_TYPE = "banner2"

class DailyViewModel : ObservableObject {
    
    @Published var bannerList: [String] = []
    @Published var videoCardList: [VideoCardItem] = []
    @Published var isLoading = false
    @Published var isFinished = false
    @Published var errorMessage: String? = nil
    @Published var nextPageUrl: String? = nil
    @Published var isError: Bool = false
    
    private var currentTask: Task<Void, Never>?
        
    private func fetchData(reqUrl: String? = nil, isRefresh: Bool = false) async {
        do {
            await MainActor.run {
                self.isLoading = true
            }
            let realReqUrl = reqUrl ?? ApiService.daily.url
            guard let url = URL(string: realReqUrl) else {
                self.errorMessage = NSLocalizedString("invalid_url", comment: "")
                self.isError = true
                self.isLoading = false
                return
            }
            
            let (data, _) = try await session.data(from: url)
            let dailyData = try JSONDecoder().decode(Daily.self, from: data)
            
            await MainActor.run {
                var itemList = dailyData.issueList[0].itemList
                itemList.removeAll { $0.type == BANNER_TYPE }
                if (reqUrl == nil) {
                    self.bannerList = itemList.map { $0.data!.cover!.feed }
                } else {
                    if (isRefresh) {
                        self.videoCardList = []
                    }
                    self.videoCardList.append(contentsOf: itemList)
                }
                self.isLoading = false
                self.nextPageUrl = dailyData.nextPageUrl
                
                if (self.nextPageUrl == nil) {
                    self.isFinished = true
                }
                self.errorMessage = nil
                self.isError = false
            }
            if (self.nextPageUrl != nil && reqUrl == nil) {
                await fetchData(reqUrl: dailyData.nextPageUrl, isRefresh: true)
            }
        } catch {
            if !(error is CancellationError) {
                await MainActor.run {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                }
            }
        }
    }
    
    func refresh() {
        if (self.isLoading) {
            return
        }
        currentTask?.cancel()
        Task {
            await MainActor.run {
                self.nextPageUrl = nil
            }
            currentTask = Task {
                await fetchData(reqUrl: self.nextPageUrl, isRefresh: true)
            }
        }
    }

    
    func loadMore() {
        if (self.nextPageUrl == nil || self.isFinished || self.isLoading) {
            return
        }
        currentTask = Task {
            await fetchData(reqUrl: self.nextPageUrl, isRefresh: false)
        }
    }
}
