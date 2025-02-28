//
//  TitleItemView.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/6.
//

import SwiftUI

struct TitleItemView : View {
    var text: String
    var body: some View {
        ZStack(alignment: .center) {
            Text(text)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black.opacity(0.87))
        }
        .padding(.top, 5)
        .padding(.bottom, 10)
    }
}
