//
//  HotTabScreen.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/9.
//

import SwiftUI

struct HotTabScreen: View {
    
    var apiUrl : String
    @StateObject var viewModel = HotTabViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(0..<viewModel.videoCardList.count, id: \.self) { index in
                    let itemData = viewModel.videoCardList[index]
                    VideoCardItemView(itemData: itemData.data!)
                }
            }
            .padding(.horizontal, 15)
        }
        .onAppear {
            Task {
                await viewModel.fetchTabData(url: apiUrl)
            }
        }
        .refreshable {
            await viewModel.fetchTabData(url: apiUrl)
        }
    }
}
