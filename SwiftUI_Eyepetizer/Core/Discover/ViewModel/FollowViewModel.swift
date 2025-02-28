//
//  FollowViewModel.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import Foundation

class FollowViewModel : ObservableObject {
    
    @Published var followList: [VideoCardItem] = []
    @Published var isLoading = false
    @Published var isFinished = false
    @Published var errorMessage: String? = nil
    @Published var nextPageUrl: String? = nil
    @Published var isError: Bool = false
    
    private var currentTask: URLSessionTask?
    
    private func fetchData(reqUrl: String? = nil, isRefresh: Bool = false) {
            currentTask?.cancel()
            
            DispatchQueue.main.async {
                self.isLoading = true
            }
            
            let realReqUrl = reqUrl ?? ApiService.followList.url
            guard let url = URL(string: realReqUrl) else {
                DispatchQueue.main.async {
                    self.errorMessage = NSLocalizedString("invalid_url", comment: "")
                    self.isError = true
                    self.isLoading = false
                }
                return
            }
            
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error as NSError? {
                    if error.code == NSURLErrorCancelled {
                        return
                    } else {
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.errorMessage = error.localizedDescription
                            self.isError = true
                        }
                        return
                    }
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        self.errorMessage = NSLocalizedString("no_data_received", comment: "")
                        self.isError = true
                        self.isLoading = false
                    }
                    return
                }
                
                do {
                    let followsData = try JSONDecoder().decode(Follow.self, from: data)
                    DispatchQueue.main.async {
                        if isRefresh {
                            self.followList = []
                        }
                        self.followList.append(contentsOf: followsData.itemList)
                        self.isLoading = false
                        self.nextPageUrl = followsData.nextPageUrl
                        
                        if self.nextPageUrl == nil {
                            self.isFinished = true
                        }
                        self.errorMessage = nil
                        self.isError = false
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.errorMessage = error.localizedDescription
                        self.isError = true
                    }
                }
            }
            
            task.resume()
            currentTask = task
        }
        
        func refresh() {
            if self.isLoading {
                return
            }
            DispatchQueue.main.async {
                self.nextPageUrl = nil
                self.errorMessage = nil
            }
            fetchData(reqUrl: nil, isRefresh: true)
        }
        
        func loadMore() {
            if self.nextPageUrl == nil || self.isFinished || self.isLoading {
                return
            }
            fetchData(reqUrl: self.nextPageUrl, isRefresh: false)
        }
}
