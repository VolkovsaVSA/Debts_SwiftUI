//
//  SortImageForButton.swift
//  Debts
//
//  Created by Sergei Volkov on 10.12.2021.
//

import SwiftUI

struct SortImageForLabel: View {
    
    var body: some View {
        Image(SortImage.increase_48x48.rawValue)
            .renderingMode(.template)
            .resizable()
            .frame(width: 18, height: 18)
            .foregroundColor(.primary)
            .padding(6)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .modifier(ShadowButtonModifire(useShadow: true))
    }
}
