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
    
    
    var body: some View {
        Section(header: Text("Backup").fontWeight(.semibold).foregroundColor(.primary)
        ) {
            if isFullVersion {
                HStack {
                    Spacer()
                    Toggle("Auto backup data", isOn: $iCloudSync)
                    Spacer()
                }
                    .modifier(CellModifire(frameMinHeight: 10, useShadow: false))
            } else {
                HStack {
                    Spacer()
                    Text("Auto backup data available in full version")
                    Spacer()
                }
                .modifier(CellModifire(frameMinHeight: 10, useShadow: false))
            }
            
        }

    }
}
