//
//  PurchasesSectionView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.12.2021.
//

import SwiftUI

struct PurchasesSection: View {
    
    
    
    var body: some View {
        Section(header: Text("Purchases").fontWeight(.semibold).foregroundColor(.primary)) {
            
            Group {
                SettingsButton(title: NSLocalizedString("Purchase Full version", comment: " ")) {
                    
                }
                SettingsButton(title: NSLocalizedString("Restore purchases", comment: " ")) {
                    
                }
            }
            .buttonStyle(.plain)
            .modifier(CellModifire(frameMinHeight: 10, useShadow: false))
        }
    }
    
}

