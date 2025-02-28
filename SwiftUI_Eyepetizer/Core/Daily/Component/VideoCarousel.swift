//
//  VideoCarousel.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/8.
//

import SwiftUI
import ACarousel
import SDWebImage
import SDWebImageSwiftUI

struct VideoCarousel: View {
    var bannerList: [String] = []
    
    var body: some View {
        ACarousel(bannerList, id: \.self, autoScroll: .active(3)) { item in
            WebImage(url: URL(string: item))
                .resizable()
                .indicator(.activity)
                .transition(.fade)
                .scaledToFit()
                .cornerRadius(4)
        }
        .frame(height: 200)
    }
}

