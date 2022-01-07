//
//  LottieContainerView.swift
//  Debts
//
//  Created by Sergei Volkov on 07.01.2022.
//

import SwiftUI

struct LottieContainerView: View {
    
    var body: some View {
        LottieView(name: "empty", loopMode: .loop)
            .padding(50)
            .offset(y: -30)
    }
}

