//
//  CategoryViewModel.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import Foundation

class CategoryViewModel : ObservableObject {
    @Published var categoryList : [Category] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading = false
    @Published var isError: Bool = false
    
    func fetchCategoryList() async {
        do {
            await MainActor.run {
                self.isLoading = true
            }
            guard let url = URL(string: ApiService.categoryList.url) else {
                self.errorMessage = NSLocalizedString("invalid_url", comment: "")
                self.isLoading = false
                self.isError = true
                return
            }
            
            let (data, _) = try await session.data(from: url)
            let categoryListInfo = try JSONDecoder().decode([Category].self, from: data)
            
            await MainActor.run {
                self.categoryList = categoryListInfo
                self.isLoading = false
                self.errorMessage = nil
                self.isError = false
            }
        } catch {
            await MainActor.run {
                self.isLoading = false
                self.errorMessage = error.localizedDescription
                self.isError = true
            }
        }
    }
}
