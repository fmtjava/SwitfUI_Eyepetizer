//
//  NewsScreen.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import SwiftUI

import SDWebImage
import SDWebImageSwiftUI
import ToastUI

let TEXT_CARD = "textCard";

struct NewsScreen: View {
    @StateObject var viewModel = NewsViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                ForEach(0..<viewModel.newsList.count, id: \.self) { index in
                    let news = viewModel.newsList[index]
                    if (news.type == TEXT_CARD) {
                        Text(news.data.text ?? "")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                            .padding(.top, 5)
                    } else {
                        let title = news.data.titleList?[0] ?? ""
                        let webUrl = decodeUrlFromActionUrl(news.data.actionUrl ?? "") ?? ""
                        
                        NavigationLink(destination: NewsDetailScreen(title: title, webUrl: webUrl), label: {
                        
                        VStack(alignment: .leading, spacing: 0) {
                            WebImage(url: URL(string: news.data.backgroundImage ?? ""))
                                .resizable()
                                .indicator(.activity)
                                .transition(.fade)
                                .clipped()
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity)
                                .frame(height: 140)
                            
                            if let titleList =  news.data.titleList {
                                ForEach(titleList.indices, id: \.self) { subIndex in
                                    
                                    let title = titleList[subIndex]
                                    
                                    Text(title)
                                        .font(.system(size: 12))
                                        .lineLimit(2)
                                        .truncationMode(.tail)
                                        .padding(.horizontal, 10)
                                        .padding(.top, 5)
                                        .padding(.bottom, subIndex == titleList.count - 1 ? 15 : 5)
                                }
                            }
                        }
                        .cornerRadius(14)
                        .background(Color.gray.opacity(0.1))
                        .padding(.all, 10)
                        })
                    }
                    
                    if index == viewModel.newsList.count - 1 {
                        LoadMoreView(
                            isLoading: viewModel.isLoading,
                            isFinished: viewModel.isFinished,
                            errorMessage: viewModel.errorMessage,
                            onRetry: {
                                viewModel.errorMessage = nil
                                viewModel.loadMore()
                            })
                        .onAppear {
                            if (news.data.id == viewModel.newsList.last?.data.id) {
                                viewModel.loadMore()
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            if viewModel.nextPageUrl == nil && !viewModel.isFinished {
                viewModel.refresh()
            }
        }
        .refreshable {
            viewModel.refresh()
        }
        .toast(isPresented: $viewModel.isError, dismissAfter: 2.0) {
            if let errorMessage = viewModel.errorMessage {
                ToastView(errorMessage).toastViewStyle(.failure)
            }
        }
    }
    
    func decodeUrlFromActionUrl(_ actionUrl: String) -> String? {
        // 查找 "url" 在字符串中的起始位置
        if let urlStartIndex = actionUrl.range(of: "url=")?.lowerBound {
            
            // 提取从 "url=" 开始的子字符串
            let urlString = String(actionUrl[urlStartIndex...])
            
            // 去掉 "url=" 前缀
            let encodedUrlString = String(urlString.dropFirst(4))
            
            // 进行 URL 解码
            if let decodedUrlString = encodedUrlString.removingPercentEncoding {
                return decodedUrlString
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}

#Preview {
    NewsScreen()
}
