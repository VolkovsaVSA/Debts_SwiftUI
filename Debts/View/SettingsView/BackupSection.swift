//
//  BackupSection.swift
//  Debts
//
//  Created by Sergei Volkov on 14.12.2021.
//

import SwiftUI

struct BackupSection: View {

    
    
    var body: some View {
        Section(header: Text("Backup").fontWeight(.semibold).foregroundColor(.primary)) {
            
            Group {
                SettingsButton(title: NSLocalizedString("Save data", comment: " ")) {
                    
                }
                SettingsButton(title: NSLocalizedString("Restore data", comment: " ")) {
                    
                }
            }
            .buttonStyle(.plain)
            .modifier(CellModifire(frameMinHeight: 10, useShadow: false))
        }
    }
}
