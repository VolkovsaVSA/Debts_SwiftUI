//
//  PersonImage.swift
//  Debts
//
//  Created by Sergei Volkov on 17.04.2021.
//

import SwiftUI

struct PersonImage: View {
    
    var size: CGFloat = 70
    var image: Data?
    
    var body: some View {
        
        if let imageData = image,
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size, alignment: .center)
                .foregroundColor(Color(UIColor.systemGray))
                .background(Color(UIColor.white))
                .clipShape(Circle())
        } else {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size, alignment: .center)
                .foregroundColor(Color(UIColor.systemGray))
                .background(Color(UIColor.white))
                .clipShape(Circle())
        }
    
    }
}

