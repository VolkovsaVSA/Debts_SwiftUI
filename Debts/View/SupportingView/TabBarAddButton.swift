//
//  TabBarAddButton.swift
//  Debts
//
//  Created by Sergei Volkov on 07.04.2021.
//

import SwiftUI

struct TabBarAddButton: View {
    
    let geometry: GeometryProxy
    
    var body: some View {
        ZStack {
             Circle()
                .foregroundColor(.white)
                .frame(width: geometry.size.width/6, height: geometry.size.width/6)
                .shadow(radius: 4)
             Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: abs(geometry.size.width/6-6), height: abs(geometry.size.width/6-6))
                .foregroundColor(AppSettings.accentColor)
         }
    }
}