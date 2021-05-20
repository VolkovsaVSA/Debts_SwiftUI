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
                .frame(width: GraphicSettings.calcRotateWidth(geometry: geometry)/6, height: GraphicSettings.calcRotateWidth(geometry: geometry)/6)
                .shadow(radius: 4)
             Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: abs(GraphicSettings.calcRotateWidth(geometry: geometry)/6-6), height: abs(GraphicSettings.calcRotateWidth(geometry: geometry)/6-6))
                .foregroundColor(AppSettings.accentColor)
         }
        
    }
}
