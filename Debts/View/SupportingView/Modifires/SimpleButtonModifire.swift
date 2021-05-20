//
//  SimpleButtonModifire.swift
//  Debts
//
//  Created by Sergei Volkov on 20.05.2021.
//

import SwiftUI

struct SimpleButtonModifire: ViewModifier {
    
    let textColor: Color
    let buttonColor: Color
    let frameWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: frameWidth)
            .padding(6)
            .foregroundColor(textColor)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(buttonColor)
            )
    }
}

