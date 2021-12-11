//
//  CompareDebtorSheetButtonModifire.swift
//  Debts
//
//  Created by Sergei Volkov on 30.11.2021.
//

import SwiftUI

struct CompareDebtorSheetButtonModifire: ViewModifier {
    
    let geometryProxy: GeometryProxy
    let buttonColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(width: geometryProxy.size.width * 0.8)
            .padding(8)
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(buttonColor)
            )
    }
}
