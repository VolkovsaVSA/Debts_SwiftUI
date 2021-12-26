//
//  AboutApp.swift
//  Debts
//
//  Created by Sergei Volkov on 26.12.2021.
//

import SwiftUI

struct AboutApp: View {

    @State private var isAnimating = false
    @State private var rotationAxis: (CGFloat, CGFloat, CGFloat) = (0, 1, 0)
    
    var animation: Animation {
        Animation.linear
            .speed(0.025)
            .repeatForever(autoreverses: false)
    }
    
    private func changeRotation() {
        switch Int.random(in: 0...2) {
            case 0:
                if rotationAxis.0 == 0 {
                    rotationAxis.0 = 1
                } else {
                    rotationAxis.0 = 0
                }
            case 1:
                if rotationAxis.1 == 0 {
                    rotationAxis.1 = 1
                } else {
                    rotationAxis.1 = 0
                }
            case 2:
                if rotationAxis.2 == 0 {
                    rotationAxis.2 = 1
                } else {
                    rotationAxis.2 = 0
                }
            default:
                rotationAxis.1 = 1
        }
    }
    
    var body: some View {
        VStack {
            Text(Bundle.main.displayName)
                .font(.title)
            Image("AppStoreIcon")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(12)
                .rotation3DEffect(.degrees(isAnimating ? 360 : 0), axis: rotationAxis)
                .padding()
                .onTapGesture {
                    changeRotation()
                }
            HStack {
                Spacer()
                Text("\(NSLocalizedString("Version:", comment: "version footer"))  \(Bundle.main.appVersionLong) (\(Bundle.main.appBuild))")
                    .font(.caption)
                Spacer()
            }
        }
        .navigationTitle("About app")
        .onAppear {
            withAnimation(animation) {
                isAnimating.toggle()
            }
        }
        
    }
}


