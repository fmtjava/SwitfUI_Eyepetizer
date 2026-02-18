//
//  IntelligentChatViewModel.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2026/2/16.
//

import Foundation

class IntelligentChatViewModel : ObservableObject {
    
    @Published var msgList: [Message] = []
    @Published var isLoading = false
    @Published var isError: Bool = false
    @Published var errorMessage: String? = nil
    
    func queryData(content: String) async {
        do {
            await MainActor.run {
                self.msgList.append(Message(role: "user", content: content))
                self.isLoading = true
            }
            guard let url = URL(string: ApiService.intelligentChat.rawValue) else {
                self.errorMessage = NSLocalizedString("invalid_url", comment: "")
                self.isLoading = false
                self.isError = true
                return
            }
            
            var request = URLRequest(url: url)
            // 1、请求方式
            request.httpMethod = "POST"
            
            // 2、添加请求头（核心步骤）
            request.setValue("application/json", forHTTPHeaderField: "content-type") // JSON 格式请求体
            request.setValue("Bearer DoCBjyODmXmuLjjkLLBY:tWGmRRiQffYWACxMvjxf", forHTTPHeaderField: "Authorization") // 认证令牌
            
            // 3、构建请求体（messages 必须用 [String: String] 等 JSON 可序列化类型，不能用 Message 结构体）
            let messages: [[String: String]] = msgList.map { ["role": $0.role, "content": $0.content] }
            let requestData: [String: Any] = ["model": "spark-x", "user": "user_id", "messages": messages]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: requestData)
            } catch {
                self.errorMessage = NSLocalizedString("JSON 序列化失败: \(error)", comment: "")
                self.isLoading = false
                self.isError = true
                return
            }
            // 4、发送网络请求
            let (data, _) = try await chatSession.data(for: request)
            // 5、响应数据解析
            let chatResponse = try JSONDecoder().decode(ChatResponse.self, from: data)
            
            if (chatResponse.code == 0) {
                await MainActor.run {
                    for choice in chatResponse.choices {
                        self.msgList.append(Message(role: choice.message.role, content: choice.message.content))
                    }
                    self.isLoading = false
                    self.isError = false
                    self.errorMessage = nil
                }
            } else {
                self.isLoading = false
                self.isError = true
                self.errorMessage = chatResponse.message
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isError = true
                self.isLoading = false
            }
        }
    }
}
