//
//  VideoCardItemView.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/6.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct VideoCardItemView : View {
    var itemData: VideoCardItemData
    
    var body: some View {
        NavigationLink(destination: VideoDetailScreen(itemData: itemData), label: {
            VStack {
                ZStack(alignment: .topLeading) {
                    WebImage(url: URL(string: itemData.cover!.feed))
                        .resizable()
                        .indicator(.activity)
                        .transition(.fade)
                        .cornerRadius(4)
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                    
                    Text(itemData.category ?? "")
                        .foregroundColor(Color.white)
                        .frame(width: 44, height: 44)
                        .background(.white.opacity(0.54))
                        .clipShape(Circle())
                        .font(.system(size: 16))
                        .offset(x: 15, y: 10)
                    
                    Text(DateUtils.formatDuration(itemData.duration ?? 0))
                        .foregroundColor(Color.white)
                        .padding(.all, 5)
                        .background(.white.opacity(0.54))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .font(.system(size: 16, weight: .bold))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        .padding(.trailing, 15)
                        .padding(.bottom, 10)
                }
                
                HStack(spacing: 0) {
                    WebImage(url: URL(string: itemData.author?.icon ?? ""))
                        .resizable()
                        .indicator(.activity)
                        .transition(.fade)
                        .scaledToFit()
                        .cornerRadius(4)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    VStack(alignment: .leading, spacing: 0) {
                        Text(itemData.title ?? "")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                        Text(itemData.author?.name ?? "")
                            .lineLimit(2)
                            .truncationMode(.tail)
                            .font(.system(size: 12))
                            .foregroundColor(.black.opacity(0.5))
                            .padding(.top, 2)
                        
                    }
                    .padding(.leading, 10)
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "arrowshape.turn.up.right")
                            .frame(width: 24, height: 24)
                    })
                }
                .padding(.top, 5)
                Divider().padding(.bottom, 5)
            }
        })
    }
}

