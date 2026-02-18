//
//  PersonScreen.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import SwiftUI
import PhotosUI

struct PersonScreen: View {
    
    @StateObject var viewModel = PersonViewModel()
    
    var body: some View {
        let displayImage = viewModel.selectedImage ?? UIImage(named: "home_ic_img_avatar")
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0.0) {
                if displayImage != nil {
                    PhotosPicker(selection: $viewModel.imageSelection, matching: .images) {
                        Image(uiImage: displayImage!)
                            .resizable()
                            .clipped()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                            .padding(.top, 30)
                    }
                    .buttonStyle(.borderless)
                    .onChange(of: viewModel.imageSelection) { _, newValue in
                        viewModel.setImage(from: newValue)
                    }
                }
                
                Text("fmtJava")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 5)
                
                HStack(spacing: 0.0) {
                    Text("person_go_homepage")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                        .padding(.leading, 2)
                }
                .padding(.top, 4)
                
                HStack(spacing: 0.0) {
                    Spacer()
                    HStack(spacing: 0.0) {
                        Image(systemName: "heart")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                            .padding(.leading, 2)
                        Text("person_collection")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .padding(.leading,3)
                    }
                    
                    Spacer()
                    
                    Rectangle()
                        .frame(width: 0.5, height: 30)
                        .background(.gray)
                    
                    Spacer()
                    
                    HStack(spacing: 0.0) {
                        Image(systemName: "message")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                            .padding(.leading, 2)
                        Text("person_comment")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .padding(.leading, 3)
                    }
                    Spacer()
                }
                .padding(.top, 20)
                
                Divider().background(.gray).padding(.top, 15)
                
                Button(action: {
                    
                }, label: {
                    Text("person_mine_message")
                        .font(.system(size: 16))
                        .foregroundColor(.black.opacity(0.5))
                        .frame(maxWidth: .infinity, minHeight: 50)
                })
                .padding(.top, 10)
                
                Button(action: {
                    
                }, label: {
                    Text("person_mine_attention")
                        .font(.system(size: 16))
                        .foregroundColor(.black.opacity(0.5))
                })
                
                Button(action: {
                    
                }, label: {
                    Text("person_mine_cache")
                        .font(.system(size: 16))
                        .foregroundColor(.black.opacity(0.5))
                        .frame(maxWidth: .infinity, minHeight: 50)
                })
                
                NavigationLink(destination: WatchRecordScreen(), label: {
                    Text("person_view_history")
                        .font(.system(size: 16))
                        .foregroundColor(.black.opacity(0.5))
                        .frame(maxWidth: .infinity, minHeight: 50)
                })
                
                Button(action: {
                    
                }, label: {
                    Text("person_feedback")
                        .font(.system(size: 16))
                        .foregroundColor(.black.opacity(0.5))
                        .frame(maxWidth: .infinity, minHeight: 50)
                })
            }
        }
    }
}

#Preview {
    PersonScreen()
}
