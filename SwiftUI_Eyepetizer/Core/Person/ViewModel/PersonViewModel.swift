//
//  PersonViewModel.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/5.
//

import Foundation
import SwiftUI
import PhotosUI

class PersonViewModel : ObservableObject {
    
    @Published var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                    return
                }
            }
        }
    }
}
