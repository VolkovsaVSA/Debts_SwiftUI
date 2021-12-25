//
//  ShadowModifire.swift
//  Debts
//
//  Created by Sergei Volkov on 22.12.2021.
//

import SwiftUI

struct ShadowButtonModifire: ViewModifier {

    let useShadow: Bool
    
    func body(content: Content) -> some View {
        content
            .shadow(color: useShadow ? .black.opacity(0.25) : Color.clear.opacity(0), radius: 10, x: 0, y: 0)
    }
}
