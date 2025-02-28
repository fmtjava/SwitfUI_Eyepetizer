//
//  VideoDetailScreen.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import SwiftUI
import AVKit
import SDWebImage
import SDWebImageSwiftUI
import ToastUI
import Combine

let VIDEO_SMALL_CARD_TYPE = "videoSmallCard"

struct VideoDetailScreen: View {
    
    var itemData: VideoCardItemData
    @StateObject var viewModel = VideoDetailViewModel()
    @State var player: AVPlayer?
    @State var cancelables = Set<AnyCancellable>()
    
    var body: some View {
        VStack(spacing: 0.0) {
            VideoPlayer(player: player).aspectRatio(16/9, contentMode: .fit)
                .onAppear {
                    if let playUrl = itemData.playUrl {
                        if let videoURL = URL(string: playUrl) {
                            player = AVPlayer(url: videoURL)
                            player?.play()
                        }
                    }
                    
                    // 监听应用程序状态变化
                    NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification).sink { _ in
                        // 进入后台时暂停播放
                        self.player?.pause()
                    }
                    .store(in: &cancelables)
                    
                    NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification).sink { _ in
                        // 返回前台时恢复播放
                        self.player?.pause()
                    }
                    .store(in: &cancelables)
                }
                .onDisappear {
                    player?.pause()
                    player = nil
                    cancelables.forEach { $0.cancel() }
                }
                
            ZStack {
                if let blurred = itemData.cover?.blurred {
                    WebImage(url: URL(string: "\(blurred)/thumbnail/\(UIScreen.main.bounds.height)x\(UIScreen.main.bounds.width)"))
                        .resizable()
                        .indicator(.activity)
                        .transition(.fade)
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: .infinity)
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0.0) {
                        Text(itemData.title ?? "")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                            .padding(.top, 10)
                        if let category =  itemData.category {
                            if let latestReleaseTime = itemData.author?.latestReleaseTime {
                                Text("\(category) / \(DateUtils.formatTimestamp(Double(latestReleaseTime)))")
                                    .font(.system(size: 12))
                                    .foregroundColor(.white)
                                    .padding(.leading, 10)
                                    .padding(.top, 10)
                            }
                        }
                        Text(itemData.description ?? "")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                            .padding(.top, 10)
                        
                        HStack(spacing: 0.0) {
                            Image(systemName: "heart")
                                .frame(width: 14, height: 14)
                                .foregroundColor(.white)
                            if let collectionCount = itemData.consumption?.collectionCount {
                                Text("\(collectionCount)")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .padding(.leading, 5)
                            }
                            Image(systemName: "arrowshape.turn.up.right")
                                .frame(width: 14, height: 14)
                                .foregroundColor(.white)
                                .padding(.leading, 30)
                            if let shareCount = itemData.consumption?.shareCount {
                                Text("\(shareCount)")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .padding(.leading, 5)
                            }
                            Image(systemName: "bubble.right")
                                .frame(width: 14, height: 14)
                                .foregroundColor(.white)
                                .padding(.leading, 30)
                            if let replyCount = itemData.consumption?.replyCount {
                                Text("\(replyCount)")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .padding(.leading, 5)
                            }
                        }
                        .padding(.leading, 10)
                        .padding(.top, 10)
                        
                        Divider().background(Color.white).padding(.top, 10)
                        
                        HStack(spacing: 0.0) {
                            if let authorIcon = itemData.author?.icon {
                                WebImage(url: URL(string: authorIcon))
                                    .resizable()
                                    .indicator(.activity)
                                    .transition(.fade)
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .padding(.leading, 10)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 0.0) {
                                if let authorName = itemData.author?.name {
                                    Text(authorName)
                                        .font(.system(size: 15))
                                        .foregroundColor(.white)
                                }
                                if let description = itemData.author?.description {
                                    Text(description)
                                        .font(.system(size: 15))
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.top, 10)
                            
                            Spacer()
                            
                            Text("add_follow")
                                .font(.system(size: 12, weight: .bold))
                                .padding(.all, 5)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .padding(.horizontal, 10)
                                .foregroundColor(.gray)
                        }
                        Divider().background(Color.white).padding(.top, 10)
                        
                        LazyVStack(alignment: .leading, spacing: 0.0) {
                            ForEach(0..<viewModel.relateVideoList.count, id: \.self) { index in
                                
                                let relateVideoData = viewModel.relateVideoList[index]
                                
                                if relateVideoData.type == VIDEO_SMALL_CARD_TYPE {
                                    HStack(spacing: 0.0) {
                                        ZStack {
                                            WebImage(url: URL(string: relateVideoData.data?.cover?.detail ?? ""))
                                                .resizable()
                                                .indicator(.activity)
                                                .transition(.fade)
                                                .frame(width: 135, height: 80)
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                            
                                            if let duration = relateVideoData.data?.duration {
                                                Text(DateUtils.formatDuration(duration))
                                                    .foregroundColor(Color.white)
                                                    .padding(.all, 3)
                                                    .background(.white.opacity(0.54))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                                    .font(.system(size: 10, weight: .bold))
                                                    .frame(maxWidth: 135, maxHeight: 80, alignment: .bottomTrailing)
                                                    .padding(.trailing, 5)
                                                    .padding(.bottom, 5)
                                            }
                                        }
                                        VStack(alignment: .leading, spacing: 0.0) {
                                            Text(relateVideoData.data?.title ?? "")
                                                .font(.system(size: 14, weight: .bold))
                                                .foregroundColor(.white)
                                            if let category = relateVideoData.data?.category {
                                                if let authorName = relateVideoData.data?.author?.name {
                                                    Text("#\(category) / \(authorName)")
                                                        .font(.system(size: 12))
                                                        .foregroundColor(.white)
                                                        .padding(.top, 10)
                                                }
                                            }
                                        }
                                        .padding(.all, 10)
                                    }
                                    .padding(.top, 10)
                                    .padding(.bottom, 5)
                                    .padding(.horizontal, 10)
                                } else {
                                    Text(relateVideoData.data?.text ?? "")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.all, 10)
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    if let cardVideoId = itemData.id {
                        if viewModel.relateVideoList.isEmpty {
                            Task {
                                await viewModel.fetchtRelateVideoList(id: cardVideoId)
                            }
                        }
                    }
                    viewModel.saveWatchVideoItem(itemData: itemData)
                }
                .refreshable {
                    if let cardVideoId = itemData.id {
                        if viewModel.relateVideoList.isEmpty {
                            Task {
                                await viewModel.fetchtRelateVideoList(id: cardVideoId)
                            }
                        }
                    }
                }
                .toast(isPresented: $viewModel.isLoading, dismissAfter: 2.0) {
                    ToastView("Loading").toastViewStyle(.indeterminate)
                }
                .toast(isPresented: $viewModel.isError, dismissAfter: 2.0) {
                    if let errorMessage = viewModel.errorMessage {
                        ToastView(errorMessage).toastViewStyle(.failure)
                    }
                }
            }
        }
        .navigationTitle(itemData.title ?? "")
        .toolbar(.hidden, for: .tabBar)
        .edgesIgnoringSafeArea(.bottom)
    }
}

