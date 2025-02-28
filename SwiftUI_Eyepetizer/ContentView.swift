//
//  ContentView.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @StateObject var viewModel = AppViewModel()
    
    var body: some View {
        ZStack {
            TabView(selection: $viewModel.selectedTabIndex) {
                NavigationStack {
                    DailyScreen().navigationTitle("")
                }
                .tabItem {
                    Button(action: {
                        viewModel.setSelectedTabIndex(index: 0)
                    }, label: {
                        Image(systemName: viewModel.selectedTabIndex == 0 ? "house.fill" : "house")
                        Text("daily_paper")
                            .font(.system(size: 12))
                            .foregroundColor(viewModel.selectedTabIndex == 0 ? .black : .black.opacity(0.38))
                    })
                }
                .tag(0)
                
                NavigationStack {
                    DiscoverScreen().navigationTitle("")
                }
                .tabItem {
                    Button(action: {
                        viewModel.setSelectedTabIndex(index: 1)
                    }, label: {
                        Image(systemName: viewModel.selectedTabIndex == 1 ? "magnifyingglass.circle.fill" : "magnifyingglass.circle")
                        Text("discover")
                            .font(.system(size: 12))
                            .foregroundColor(viewModel.selectedTabIndex == 1 ? .black : .black.opacity(0.38))
                    })
                }
                .tag(1)
                
                NavigationStack {
                    HotScreen().navigationTitle("")
                }
                .tabItem {
                    Button(action: {
                        viewModel.setSelectedTabIndex(index: 2)
                    }, label: {
                        Image(systemName: viewModel.selectedTabIndex == 2 ? "flame.fill" : "flame")
                        Text("hot")
                            .font(.system(size: 12))
                            .foregroundColor(viewModel.selectedTabIndex == 2 ? .black : .black.opacity(0.38))
                    })
                }
                .tag(2)
                
                NavigationStack {
                    PersonScreen().navigationTitle("")
                }
                .tabItem {
                    Button(action: {
                        viewModel.setSelectedTabIndex(index: 3)
                    }, label:{
                        Image(systemName: viewModel.selectedTabIndex == 3 ? "person.fill" : "person")
                        Text("mime")
                            .font(.system(size: 12))
                            .foregroundColor(viewModel.selectedTabIndex == 3 ? .black : .black.opacity(0.38))
                    })
                }
                .tag(3)
            }
        }
    }
}

#Preview {
    ContentView()
}
