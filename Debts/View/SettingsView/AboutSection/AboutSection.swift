//
//  AboutSection.swift
//  Debts
//
//  Created by Sergei Volkov on 06.01.2022.
//

import SwiftUI

struct AboutSection: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
    var body: some View {
        Section(header: Text(LocalStrings.Views.Settings.aboutApp).fontWeight(.semibold).foregroundColor(.primary)) {
            NavigationLink {
                AboutApp()
            } label: {
                HStack(alignment: .center, spacing: 8) {
                    Image(systemName: "gear.badge.questionmark")
                        .frame(width: 28, height: 28)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .circular)
                                .fill(Color.gray)
                        )
                    Text(LocalStrings.Views.Settings.aboutApp)
                }
            }
            
            //HelloView
            NavigationLink(isActive: $settingsVM.helloViewIsActive) {
                HelloView(helloVM: HelloViewModel(colorScheme: colorScheme))
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle(LocalStrings.Views.Settings.whatsNew)
            } label: {
                HStack(alignment: .center, spacing: 8) {
                    Image(systemName: "questionmark")
                        .frame(width: 28, height: 28)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .circular)
                                .fill(Color.blue)
                        )
                    Text(LocalStrings.Views.Settings.whatsNew)
                }
            }
        }
        .listRowSeparator(.hidden)
    }
}


