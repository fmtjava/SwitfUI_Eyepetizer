//
//  HotScreen.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import SwiftUI
import ToastUI

struct HotScreen: View {
    @StateObject var viewModel = HotViewModel()

    var body: some View {
        VStack(spacing: 0) {
            TitleBar(title: "hot")
            HStack(alignment: .center, spacing: 0) {
                ForEach(0..<viewModel.tabList.count, id: \.self) { index in
                    Button(action: {
                        viewModel.setSelectedTabIndex(index: index)
                    }, label: {
                        VStack {
                            Text(viewModel.tabList[index].name)
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
                ForEach(0..<viewModel.tabList.count, id: \.self) { index in
                    HotTabScreen(apiUrl: viewModel.tabList[index].apiUrl).tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .edgesIgnoringSafeArea(.all)
        }
        .background(.white)
        .onAppear {
            if viewModel.tabList.isEmpty && !viewModel.isLoading {
                Task {
                    await viewModel.fetchHotTabList()
                }
            }
        }
        .toast(isPresented: $viewModel.isError, dismissAfter: 2.0) {
            if let errorMessage = viewModel.errorMessage {
                ToastView(errorMessage).toastViewStyle(.failure)
            }
        }
        .toast(isPresented: $viewModel.isLoading, dismissAfter: 2.0) {
            ToastView("Loading").toastViewStyle(.indeterminate)
        }
    }
}
