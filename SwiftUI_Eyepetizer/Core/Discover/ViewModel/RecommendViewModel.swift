//
//  RecommendViewModel.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import Foundation
import SwiftUI

let HORIZONTAL_SCROLL_CARD = "horizontalScrollCard"

class RecommendViewModel : ObservableObject {
    @Published var recommedCardList: [RecommendItem] = []
    @Published var isLoading = false
    @Published var isFinished = false
    @Published var nextPageUrl: String? = nil
    @Published var errorMessage: String? = nil
    @Published var isError: Bool = false
    
    private var currentTask: Task<Void, Never>?
        
    private func fetchData(reqUrl: String? = nil, isRefresh: Bool = false) async {
        do {
            await MainActor.run {
                self.isLoading = true
            }
            let realReqUrl = reqUrl ?? ApiService.recommendList.url
            guard let url = URL(string: realReqUrl) else {
                self.errorMessage = NSLocalizedString("invalid_url", comment: "")
                return
            }
            
            let (data, _) = try await session.data(from: url)
            let recommendData = try JSONDecoder().decode(Recommend.self, from: data)
            
            await MainActor.run {
                var itemList = recommendData.itemList
                itemList.removeAll { $0.type == HORIZONTAL_SCROLL_CARD }
                if (isRefresh) {
                    self.recommedCardList = []
                }
                self.recommedCardList.append(contentsOf: itemList)
                self.isLoading = false
                self.nextPageUrl = recommendData.nextPageUrl
                
                if (self.nextPageUrl == nil) {
                    self.isFinished = true
                }
                self.errorMessage = nil
                self.isError = false
            }
        } catch {
            print(error.localizedDescription)
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
