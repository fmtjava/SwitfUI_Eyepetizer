//
//  TopicScreen.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import ToastUI

struct TopicScreen: View {
    @StateObject var viewModel = TopicViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(0..<viewModel.topicList.count, id: \.self) { index in
                    let topic = viewModel.topicList[index]
                    VStack(spacing: 0) {
                        WebImage(url: URL(string: topic.data.image))
                            .resizable()
                            .indicator(.activity)
                            .transition(.fade)
                            .clipped()
                            .cornerRadius(4)
                            .frame(height: 200)
                        Divider().padding(.top, 10)
                        
                        if index == viewModel.topicList.count - 1 {
                            LoadMoreView(
                                isLoading: viewModel.isLoading,
                                isFinished: viewModel.isFinished,
                                errorMessage: viewModel.errorMessage,
                                onRetry: {
                                    viewModel.errorMessage = nil
                                    viewModel.loadMore()
                                })
                            .onAppear {
                                if (topic.data.id == viewModel.topicList.last?.data.id) {
                                    viewModel.loadMore()
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 10)
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
}

#Preview {
    TopicScreen()
}
