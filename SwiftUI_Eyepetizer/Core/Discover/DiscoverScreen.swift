//
//  DiscoverScreen.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import SwiftUI

struct DiscoverScreen: View {
    
    let tabs = ["关注", "分类", "专题", "咨询", "推荐"]
    @StateObject var viewModel = DiscoverViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            TitleBar(title: "discover")
            
            HStack(alignment: .center, spacing: 0) {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Button(action: {
                        viewModel.setSelectedTabIndex(index: index)
                    }, label: {
                        VStack {
                            Text(tabs[index])
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(viewModel.selectedTabIndex == index ? .black : .black.opacity(0.5))
                            
                                Capsule()
                                .fill(viewModel.selectedTabIndex == index ? .black : .white)
                                    .frame(height: 2)
                        }
                    })
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 60)
            
            TabView(selection: $viewModel.selectedTabIndex) {
                FollowScreen().tag(0)
                CategoryScreen().tag(1)
                TopicScreen().tag(2)
                NewsScreen().tag(3)
                RecommendScreen().tag(4)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .edgesIgnoringSafeArea(.all)
        }
        .background(.white)
    }
}

#Preview {
    DiscoverScreen()
}
