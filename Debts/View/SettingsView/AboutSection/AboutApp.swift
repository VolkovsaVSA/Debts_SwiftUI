//
//  AboutApp.swift
//  Debts
//
//  Created by Sergei Volkov on 26.12.2021.
//

import SwiftUI

struct AboutApp: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
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
            Text(LocalStrings.indebt)
                .font(.title)
            Image("AppStoreIcon" + ImageSchemeHelper.selectSuffixForScheme(colorScheme: colorScheme))
                .resizable()
                .frame(width: 120, height: 120, alignment: .center)
                .cornerRadius(12)
                .rotation3DEffect(.degrees(isAnimating ? 360 : 0), axis: rotationAxis)
                .padding(40)
                .onTapGesture {
                    changeRotation()
                }
            HStack {
                Spacer()
                Text("\(LocalStrings.Views.Settings.version)  \(Bundle.main.appVersionLong) (\(Bundle.main.appBuild))")
                    .font(.caption)
                    .onTapGesture {
                        if settingsVM.downloadModeCounter < 10 {
                            settingsVM.downloadModeCounter += 1
                            if settingsVM.downloadModeCounter == 10 {
                                settingsVM.downloadModeActive = true
                            }
                        }
                    }
                
                Spacer()
            }
            if settingsVM.downloadModeActive {
                NavigationLink(LocalStrings.Views.Settings.downloadMode) {
                    DownloadModeView()
                        .navigationTitle(LocalStrings.Views.Settings.downloadMode)
                }
                .buttonStyle(.bordered)
                .padding()
//                Button("Delete all data", role: .destructive) {
//                    CDStack.shared.clearDatabase()
//                }
//                .buttonStyle(.bordered)
//                .padding()
            }
            
//            NavigationLink(LocalStrings.Views.Settings.downloadMode) {
//                DownloadModeView()
//                    .navigationTitle(LocalStrings.Views.Settings.downloadMode)
//            }
//            .buttonStyle(.bordered)
//            .padding()
//
//            NavigationLink("Старые данные") {
//                TestMigrationDataView()
//            }
//            .buttonStyle(.bordered)
//            .padding()
//
//            Button("Удалить ВСЕ НОВЫЕ данные", role: .destructive) {
//                CDStack.shared.clearDatabase()
//            }
//            .buttonStyle(.bordered)
//            .padding()

        }
        .navigationTitle(LocalStrings.Views.Settings.aboutApp)
        .onAppear {
            withAnimation(animation) {
                isAnimating.toggle()
            }
        }
        
    }
}


