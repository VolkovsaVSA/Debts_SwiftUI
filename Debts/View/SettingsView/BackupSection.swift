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
        Section(header: Text("Backup").fontWeight(.semibold).foregroundColor(.primary)
        ) {
            if isFullVersion {
                SettingsToggleCell(title: LocalizedStringKey("iCloud backup"),
                                   systemImage: iCloudSync ? "checkmark.icloud.fill" : "icloud.slash",
                                   isOn: $iCloudSync,
                                   backgroundColor: iCloudSync ? .blue : .red)
                    .onChange(of: iCloudSync) { newValue in
                        if iCloudSync {
                            alertShow.toggle()
                        }
                    }
            } else {
                Text("Auto backup data available in full version")
                    .multilineTextAlignment(.leading)
            }
            
        }
        .alert("Attention!", isPresented: $alertShow) {
            
        } message: {
            Text("If do you need to load data from iCloud immediately please restart the application.")
        }


    }
}
