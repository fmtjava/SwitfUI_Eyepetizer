//
//  DailyScreen.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import ACarousel
import ToastUI

let TEXT_HEADER_TYPE = "textHeader"

struct DailyScreen: View {
    @StateObject var viewModel = DailyViewModel()
    
    var body: some View {
        VStack {
            TitleBar(title: "daily_paper", showDivider: true, onSearchTapped: {
                AnyView(IntelligentChatPage())
            })
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if viewModel.bannerList.count > 0 {
                        VideoCarousel(bannerList: viewModel.bannerList)
                    }
                    LazyVStack {
                        ForEach(0..<viewModel.videoCardList.count, id: \.self) { index in
                            let itemData = viewModel.videoCardList[index]
                            if (itemData.type == TEXT_HEADER_TYPE) {
                                TitleItemView(text: itemData.data!.text ?? "")
                            } else {
                                VideoCardItemView(itemData: itemData.data!)
                                    .onAppear {
                                        if (itemData.data?.id == viewModel.videoCardList.last?.data?.id) {
                                            viewModel.loadMore()
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 15)
                
                LoadMoreView(
                    isLoading: viewModel.isLoading,
                    isFinished: viewModel.isFinished,
                    errorMessage: viewModel.errorMessage,
                    onRetry: {
                        viewModel.errorMessage = nil
                        viewModel.loadMore()
                    })
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
    }
}

