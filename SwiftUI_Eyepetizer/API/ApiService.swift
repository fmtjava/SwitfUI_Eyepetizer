//
//  ApiService.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/8.
//

import Foundation

let baseURL = "https://baobab.kaiyanapp.com/api/"

enum ApiService : String {
    
    case daily = "v2/feed?num=0"
    
    case followList = "v4/tabs/follow"
    
    case rankList = "v4/rankList"
    
    case categoryList = "v4/categories"
    
    case specialTopicList = "v3/specialTopics"
    
    case newsList = "v7/information/list?vc=6030000&deviceModel=Ios"
    
    case recommendList = "v7/community/tab/rec"
    
    case relatedList = "v4/video/related"
    
    var url : String {
        return baseURL + self.rawValue
    }
}

let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10.0
        configuration.timeoutIntervalForResource = 10.0
        return URLSession(configuration: configuration)
    }()
