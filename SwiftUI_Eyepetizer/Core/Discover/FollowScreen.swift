//
//  FollowScreen.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import ToastUI

struct FollowScreen: View {
    
    @State var isScrolling = false
    @StateObject var viewModel = FollowViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(0..<viewModel.followList.count, id: \.self) { index in
                    
                    let followData = viewModel.followList[index]
                    
                    VStack(spacing: 0.0) {
                        HStack(spacing: 0.0) {
                            WebImage(url: URL(string: followData.data?.header?.icon ?? ""))
                                .resizable()
                                .indicator(.activity)
                                .transition(.fade)
                                .clipShape(Circle())
                                .frame(width: 40,height: 40)
                            
                            VStack(alignment: .leading, spacing: 0.0) {
                                Text(followData.data?.header?.title ?? "")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                                Text(followData.data?.header?.description ?? "")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black.opacity(0.26))
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .padding(.top, 3)
                            }
                            .padding(.leading, 10)
                            
                            Spacer()
                            
                            Text("+关注")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                                .padding(.all, 5)
                                .background(.black.opacity(0.05))
                                .clipped()
                                .cornerRadius(5)
                                .padding(.trailing, 10)
                        }
                        .padding(.bottom, 10)
                        
                        if let horizontalList = followData.data?.itemList {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 0.0) {
                                    ForEach(0..<horizontalList.count, id: \.self) { subIndex in
                                        
                                        let itemData = horizontalList[subIndex]
                                        if let videoItemData =  itemData.data {
                                                VStack(alignment: .leading ,spacing: 0) {
                                                    NavigationLink(destination: VideoDetailScreen(itemData: videoItemData), label: {
                                                        ZStack(alignment: .topTrailing) {
                                                            WebImage(url: URL(string: videoItemData.cover?.feed ?? ""))
                                                                .resizable()
                                                                .indicator(.activity)
                                                                .transition(.fade)
                                                                .cornerRadius(4)
                                                                .frame(width: 300,height: 180)
                                                            Text(itemData.data?.category ?? "")
                                                                .foregroundColor(.black)
                                                                .font(.system(size: 13, weight: .bold))
                                                                .padding(.all, 6)
                                                                .background(.white.opacity(0.54))
                                                                .cornerRadius(4)
                                                                .padding(.top, 8)
                                                                .padding(.trailing, 8)
                                                        }
                                                    })
                                                    .disabled(isScrolling)
                                                    
                                                    Text(videoItemData.title ?? "")
                                                        .foregroundColor(.black)
                                                        .font(.system(size: 14, weight: .bold))
                                                        .padding(.top, 5)
                                                        .lineLimit(1)
                                                        .truncationMode(.tail)
                                                    
                                                    if let latestReleaseTime = itemData.data?.author?.latestReleaseTime {
                                                        Text(DateUtils.formatTimestamp(Double(latestReleaseTime) / 1000))
                                                            .font(.system(size: 12))
                                                            .foregroundColor(.black.opacity(0.26))
                                                            .padding(.top, 3)
                                                    }
                                                }
                                                .padding(.trailing, 15)
                                        }
                                    }
                                }
                            }
                            .gesture(
                                DragGesture(minimumDistance: 1)
                                    .onChanged { _ in
                                        isScrolling = true
                                    }
                                    .onEnded { _ in
                                        isScrolling = false
                                    }
                            )
                        }
                        
                        Divider().padding(.top, 10)
                        
                        if index == viewModel.followList.count - 1 {
                            LoadMoreView(
                                isLoading: viewModel.isLoading,
                                isFinished: viewModel.isFinished,
                                errorMessage: viewModel.errorMessage,
                                onRetry: {
                                    viewModel.errorMessage = nil
                                    viewModel.loadMore()
                                })
                            .onAppear {
                                if let listData = followData.data {
                                    if viewModel.followList.count > 0 && listData.id == viewModel.followList.last?.data?.id {
                                        viewModel.loadMore()
                                    }
                                }
                            }
                        }
                    }
                    .padding(.leading, 15)
                    .padding(.bottom, 15)
                }
            }
        }
        .onAppear {
            if viewModel.followList.isEmpty && viewModel.nextPageUrl == nil && !viewModel.isFinished {
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
    FollowScreen()
}
