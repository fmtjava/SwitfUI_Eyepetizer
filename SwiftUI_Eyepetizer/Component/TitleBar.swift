//
//  TitleBar.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/9.
//

import SwiftUI

struct TitleBar: View {
    var title : String
    var showDivider: Bool = false
    private var titleLocalized: String {
        NSLocalizedString(title, comment: "")
    }
    var body: some View {
        VStack {
            ZStack {
                Text(titleLocalized)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 45)
            .background(Color.white)
            
            if showDivider {
                Divider().background(Color.gray)
            }
        }
    }
}
