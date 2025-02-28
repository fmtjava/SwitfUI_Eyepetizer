//
//  NewsDetailScreen.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import SwiftUI
import WebView

struct NewsDetailScreen: View {
    var title: String
    var webUrl: String
    @StateObject var webViewStore = WebViewStore()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
              WebView(webView: webViewStore.webView)
                .navigationBarTitle(Text(verbatim: title), displayMode: .inline)
                .navigationBarItems(leading: HStack {
                  Button(action: goBack) {
                    Image(systemName: "chevron.left")
                      .imageScale(.large)
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 32, height: 32)
                  }
                })
            }.onAppear {
              self.webViewStore.webView.load(URLRequest(url: URL(string: webUrl)!))
            }
            .toolbarVisibility(.hidden, for: .navigationBar)
            .toolbar(.hidden, for: .tabBar)
            .edgesIgnoringSafeArea(.bottom)
          }
    
    func goBack() {
        if webViewStore.canGoBack {
            webViewStore.webView.goBack()
        } else {
            dismiss()
        }
    }
}

