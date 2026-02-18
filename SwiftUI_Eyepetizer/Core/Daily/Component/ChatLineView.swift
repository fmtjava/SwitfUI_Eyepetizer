//
//  ChatLineView.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2026/2/17.
//

import SwiftUI

let ASSISTANT_ROLE = "assistant";

struct ChatLineView: View {
    var msg: Message
    var body: some View {
        if (msg.role == ASSISTANT_ROLE) {
            HStack {
                Text(msg.content)
                    .font(.system(size: 20))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.9, alignment: .leading)
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 4)
        } else {
            VStack {
                Text(msg.content)
                    .font(.system(size: 20))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.9, alignment: .trailing)
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 4)
        }
    }
}

