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
                .frame(width: GraphicSettings.calcRotateWidth(geometry: geometry)/7, height: GraphicSettings.calcRotateWidth(geometry: geometry)/7)
                .shadow(color: .black.opacity(0.8), radius: 6, x: 4, y: 4)
             Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: abs(GraphicSettings.calcRotateWidth(geometry: geometry)/7-6), height: abs(GraphicSettings.calcRotateWidth(geometry: geometry)/7-6))
                .foregroundColor(AppSettings.accentColor)
         }
        
    }
}
