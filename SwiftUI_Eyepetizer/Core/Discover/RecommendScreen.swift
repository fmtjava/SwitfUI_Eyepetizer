//
//  RecommendScreen.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import SwiftUI
import WaterfallGrid
import SDWebImage
import SDWebImageSwiftUI
import ToastUI

let VIDEO_TYPE = "video"

struct RecommendScreen: View {
    @StateObject var viewModel = RecommendViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0.0) {
                WaterfallGrid((0..<viewModel.recommedCardList.count), id: \.self) { index in
                    CardView(card: viewModel.recommedCardList[index], index: index, viewModel: viewModel)
                }
                .gridStyle(columns: 2)
                .padding(.horizontal, 5)
                LoadMoreView(
                    isLoading: viewModel.isLoading,
                    isFinished: viewModel.isFinished,
                    errorMessage: viewModel.errorMessage,
                    onRetry: {
                        viewModel.errorMessage = nil
                        viewModel.loadMore()
                    })
                .padding(.top, 30)
            }
        }
        .background(.gray.opacity(0.1))
        .onAppear {
            if viewModel.recommedCardList.isEmpty && viewModel.nextPageUrl == nil && !viewModel.isFinished {
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
    
    struct CardView: View {
        let card: RecommendItem
        let index: Int
        @ObservedObject var viewModel: RecommendViewModel
        
        var body: some View {
            VStack(alignment: .leading, spacing: 0.0) {
                ZStack(alignment: .topTrailing) {
                    WebImage(url: URL(string: card.data.content?.data?.cover?.feed ?? ""))
                        .resizable()
                        .indicator(.activity)
                        .mask(
                            UnevenRoundedRectangle(
                                topLeadingRadius: 4,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 4
                            )
                        )
                        .aspectRatio(contentMode: .fit)
                    
                    if let urls = card.data.content?.data?.urls {
                        if urls.count > 1 {
                            Image(systemName: "photo.stack")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .padding(.top, 5)
                                .padding(.trailing, 5)
                        }
                    } else {
                        Image(systemName: card.data.content?.type == VIDEO_TYPE ? "play.circle.fill" : "photo.stack")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .padding(.top, 5)
                            .padding(.trailing, 5)
                    }
                }
                Text(card.data.content?.data?.description ?? "")
                    .font(.system(size: 14))
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 10)
                
                HStack(spacing: 0.0) {
                    HStack(spacing: 0.0) {
                        WebImage(url: URL(string: card.data.content?.data?.owner?.avatar ?? ""))
                            .resizable()
                            .indicator(.activity)
                            .transition(.fade)
                            .frame(width: 24, height: 24)
                            .clipShape(Circle())
                        
                        Text(card.data.content?.data?.owner?.nickname ?? "")
                            .font(.system(size: 12))
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .padding(.horizontal, 3)
                            .frame(width: 80)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 0.0) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        if let colleactionCount = card.data.content?.data?.consumption?.collectionCount {
                            Text("\(colleactionCount)")
                                .font(.system(size: 12))
                                .padding(.horizontal, 3)
                        }
                    }
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 10)
            }
            .background(.white)
            .cornerRadius(4)
            .onAppear {
                if viewModel.recommedCardList.count > 0 && card.id == viewModel.recommedCardList.last?.id {
                        viewModel.loadMore()
                    }
            }
        }
    }
}

#Preview {
    RecommendScreen()
}
