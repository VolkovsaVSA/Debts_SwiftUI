//
//  ImagePicker.swift
//  Debts
//
//  Created by Sergei Volkov on 06.12.2021.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: Data?
    @Binding var showActivity: Bool

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        guard let unwrapImage = image as? UIImage else { return }
                        self.parent.showActivity = true
                        ImageCompressor.compress(image: unwrapImage, maxByte: 50000) { resizeImage in
                            guard let compressedImage = resizeImage?.jpegData(compressionQuality: 0.1) else { return }
                            print(compressedImage.description)
                            DispatchQueue.main.async {
                                self.parent.image = compressedImage
                                self.parent.showActivity = false
                            }
                        }
                        
                    }
                }
            }
            
        }
        
    }
    
}
