//
//  BackgroundViewModifire.swift
//  Debts
//
//  Created by Sergei Volkov on 02.12.2021.
//

import SwiftUI

struct BackgroundViewModifire: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .background(
                Image("4")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                    .overlay(Color.black.opacity(colorScheme == .dark ? 0.3 : 0.0))
                    .blur(radius: 2)
                    .ignoresSafeArea(.keyboard , edges: .all)
            )
    }
}
