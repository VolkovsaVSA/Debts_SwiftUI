//
//  GrearsAnimationView.swift
//  Debts
//
//  Created by Sergei Volkov on 11.01.2022.
//

import SwiftUI

struct GearsAnimationView: View {
    
    @State private var lottieID = UUID()
    
    var body: some View {
        LottieView(name: "gear", loopMode: .loop)
            .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.width * 0.6, alignment: .center)
            .id(lottieID)
            .onAppear {
                lottieID = UUID()
            }
    }
}
