//
//  BackupSection.swift
//  Debts
//
//  Created by Sergei Volkov on 14.12.2021.
//

import SwiftUI

struct BackupSection: View {

    @AppStorage(UDKeys.iCloudSync) private var iCloudSync: Bool = false
    @AppStorage(IAPProducts.fullVersion.rawValue) private var isFullVersion: Bool = false
    
    @State private var alertShow = false
    
    var body: some View {
        Section(header: Text(LocalStrings.Views.Settings.backup).fontWeight(.semibold).foregroundColor(.primary)
        ) {
            if isFullVersion {
                SettingsToggleCell(title: LocalStrings.Views.Settings.iCloudBackup,
                                   systemImage: iCloudSync ? "checkmark.icloud.fill" : "icloud.slash",
                                   isOn: $iCloudSync,
                                   backgroundColor: iCloudSync ? .blue : .red)
                    .onChange(of: iCloudSync) { newValue in
                        if iCloudSync {
                            alertShow.toggle()
                        }
                    }
            } else {
                Text(LocalStrings.Views.Settings.autoBackup)
                    .multilineTextAlignment(.leading)
            }
            
        }
        .alert(LocalStrings.Alert.Title.attention, isPresented: $alertShow) {
            
        } message: {
            Text(LocalStrings.Views.Settings.ifDoYouNeedToLoadData)
        }


    }
}
