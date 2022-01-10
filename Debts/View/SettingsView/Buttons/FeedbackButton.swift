//
//  FeedbackButton.swift
//  Debts
//
//  Created by Sergei Volkov on 11.07.2021.
//

import SwiftUI

struct FeedbackButton: View {
    
    let buttonText: String
    var image: String?
    var systemImage: String?
    @State var disableButton = false
    let backgroundColor: Color
    
    @State private var imageSize: CGFloat = 24
    
    var action: ()->()
    
    var body: some View {
        Button {
            action()
        } label: {
            
            HStack{
                if let img = image {
                    Image(img)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: imageSize, height: imageSize)
                } else {
                    if let sysimg = systemImage {
                        Image(systemName: sysimg)
                            .frame(width: 28, height: 28)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 6, style: .circular)
                                            .fill(backgroundColor)
                            )
                    }
                }
                
                VStack(alignment: .leading ,spacing: 0) {
                    Text(buttonText)
                    if disableButton {
                        Text(LocalStrings.Other.toSendAnEmail)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 10, weight: .thin, design: .default))
                    }
                }
                Spacer()
            }
        }
        .disabled(disableButton)
        .buttonStyle(.plain)
    }
}

