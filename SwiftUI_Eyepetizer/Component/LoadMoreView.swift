//
//  LoadMoreView.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/8.
//

import SwiftUI

struct LoadMoreView: View {
    var isLoading: Bool
    var isFinished: Bool
    var errorMessage: String?
    var onRetry: (() -> Void)?
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView().padding()
            }
            
            if isFinished {
                Text("no_more_data")
                    .foregroundColor(.gray)
                    .padding()
            }
            
            if errorMessage != nil {
                Button(action: {
                    onRetry?()
                }, label: {
                    HStack {
                        Text("load_fail")
                            .foregroundColor(.black.opacity(0.87))
                        Image(systemName: "arrow.counterclockwise")
                            .foregroundColor(.black.opacity(0.87))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                })
            }
        }
    }
}
