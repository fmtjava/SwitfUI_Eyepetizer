//
//  IntelligentChatPage.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2026/2/16.
//

import SwiftUI
import ToastUI

struct IntelligentChatPage: View {
    
    @StateObject var viewModel = IntelligentChatViewModel()
    @State var chatInput: String = ""
    @State private var loadTask: Task<Void, Never>?
    
    private var inputBar: some View {
        HStack(spacing: 0) {
            TextField("send_mesage_tip", text: $chatInput)
                .padding(.horizontal, 12)
                .frame(height: 40)
                .background(.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 4))
            Spacer()
            Button(action: {
                sendMessage()
            }, label: {
                Text("send")
                    .font(.system(size: 16))
                    .foregroundColor(chatInput.isEmpty ? Color.white.opacity(0.3) : Color.white)
            })
            .padding(.leading, 5)
            .frame(width: 70, height: 40)
            .background(chatInput.isEmpty ? Color.blue.opacity(0.3) : Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 35))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(Color(UIColor.systemBackground))
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        ForEach(0..<viewModel.msgList.count, id: \.self) { index in
                            let msg = viewModel.msgList[index]
                            ChatLineView(msg: msg)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .padding(.bottom, 16)
                    .frame(minHeight: geometry.size.height - 60, alignment: .topLeading)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .background(Color.gray.opacity(0.2))
                }
                .frame(maxHeight: .infinity)
                inputBar
            }
        }
        .navigationTitle("intellgent_chat")
        .toolbar(.hidden, for: .tabBar)
        .toast(isPresented: $viewModel.isError, dismissAfter: 2.0) {
            if let errorMessage = viewModel.errorMessage {
                ToastView(errorMessage).toastViewStyle(.failure)
            }
        }
        .onDisappear {
            loadTask?.cancel()
        }
    }
    
    func sendMessage() {
        if (self.chatInput == "") {
            return
        }
        let content = self.chatInput
        self.chatInput = ""
        loadTask = Task {
            await viewModel.queryData(content: content)
        }
    }
}

#Preview {
    IntelligentChatPage()
}
