//
//  WatchRecordScreen.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct WatchRecordScreen: View {
    
    @StateObject var viewModel = WatchRecordViewModel()
    
    var body: some View {
        List {
            ForEach(0..<viewModel.watchVideoItemList.count, id: \.self) { index in
                
                let watchVideoItem =  viewModel.watchVideoItemList[index]
                
                HStack(spacing: 0.0) {
                    ZStack {
                        WebImage(url: URL(string: watchVideoItem.cover?.detail ?? ""))
                            .resizable()
                            .indicator(.activity)
                            .transition(.fade)
                            .frame(width: 135, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        if let duration = watchVideoItem.duration {
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
                        Text(watchVideoItem.title ?? "")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black.opacity(0.87))
                        if let category = watchVideoItem.category {
                            if let authorName = watchVideoItem.author?.name {
                                Text("#\(category) / \(authorName)")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black.opacity(0.26))
                                    .padding(.top, 5)
                            }
                        }
                    }
                    .padding(.all, 10)
                }
                .listRowSeparator(.hidden)
            }
            .onDelete(perform: viewModel.deleteItem)
        }
        .listStyle(.plain)
        .listRowSeparator(.hidden)
        .navigationTitle("person_view_history")
        .toolbar(.hidden, for: .tabBar)
        .edgesIgnoringSafeArea(.bottom)
    }
    
}

#Preview {
    WatchRecordScreen()
}
