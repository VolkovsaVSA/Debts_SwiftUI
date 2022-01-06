//
//  CellModifire.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct CellModifire: ViewModifier {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let frameMinHeight: CGFloat
    let useShadow: Bool
    
    func body(content: Content) -> some View {
        content
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .frame(minHeight: frameMinHeight)
            .lineLimit(nil)
            .padding(12)
            .background(colorScheme == .dark ? .thinMaterial : .regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .modifier(ShadowButtonModifire(useShadow: useShadow))
    }
}



