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
                .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                .shadow(radius: 4)
             Image(systemName: "plus.circle.fill")
                 .resizable()
                 .aspectRatio(contentMode: .fit)
                 .frame(width: geometry.size.width/7-6 , height: geometry.size.width/7-6)
                .foregroundColor(Color(UIColor.systemGreen))
         }
    }
}
