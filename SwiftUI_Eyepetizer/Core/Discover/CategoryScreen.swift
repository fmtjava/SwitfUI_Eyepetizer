//
//  CategoryScreen.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import ToastUI

struct CategoryScreen: View {
    @StateObject var viewModel = CategoryViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())],
                      alignment: .center,
                      spacing: 10.0,
                      pinnedViews: []) {
                ForEach(viewModel.categoryList.indices, id: \.self) { index in
                    let category = viewModel.categoryList[index]
                    ZStack {
                        WebImage(url: URL(string: category.bgPicture))
                            .resizable()
                            .indicator(.activity)
                            .transition(.fade)
                            .clipped()
                            .cornerRadius(4)
                            .frame(height: 200)
                        
                        Text("#\(category.name)")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal,10)
        }
        .onAppear {
            if viewModel.categoryList.isEmpty && !viewModel.isLoading {
                Task {
                    await viewModel.fetchCategoryList()
                }
            }
        }
        .refreshable {
            await viewModel.fetchCategoryList()
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

#Preview {
    CategoryScreen()
}
