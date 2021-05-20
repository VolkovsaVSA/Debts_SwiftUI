//
//  CellModifire.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct CellModifire: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .padding(12)
            .background(Color(UIColor.systemIndigo).opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.vertical, 4)
    }
}

