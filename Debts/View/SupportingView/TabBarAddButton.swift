//
//  TabBarAddButton.swift
//  Debts
//
//  Created by Sergei Volkov on 07.04.2021.
//

import SwiftUI

struct TabBarAddButton: View {
    
//    let geometry: GeometryProxy
    let size: CGFloat
    
    var body: some View {
        ZStack {
             Circle()
                .foregroundColor(.white)
                .frame(width: size, height: size)
                .shadow(color: .black.opacity(0.8), radius: 6, x: 4, y: 4)
             Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: abs(size-6), height: abs(size-6))
                .foregroundColor(AppSettings.accentColor)
         }
        
    }
}
