//
//  PurchasesSectionView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.12.2021.
//

import SwiftUI
import StoreKit

struct PurchasesSection: View {
    
    @EnvironmentObject private var storeManager: StoreManager
    @State private var showPurchaseWarning = false
    
    @AppStorage(IAPProducts.fullVersion.rawValue) var isFullVersion: Bool = false
    
    var body: some View {
        Section(header: Text("Purchases").fontWeight(.semibold).foregroundColor(.primary)) {
            Group {
                if isFullVersion {
                    HStack {
                        Spacer()
                        Text("You use a full version")
                        Spacer()
                    }
                    
                } else {
                    SettingsButton(title: NSLocalizedString("Purchase Full version", comment: " ")) {
                        showPurchaseWarning = true
                    }
                }
//                
//                SettingsButton(title: NSLocalizedString("Restore purchases", comment: " ")) {
//                    Task {
//                        try await AppStore.sync()
//                    }
//                }
            }
            .buttonStyle(.plain)
            .modifier(CellModifire(frameMinHeight: 10, useShadow: false))
        }
        .alert(LocalStrings.purchesingWarning(price: storeManager.priceFullVersion),
               isPresented: $showPurchaseWarning) {
            if let product = storeManager.products?.first {
                Button("Purchase", role: .destructive) {
                    Task.init {
                        try await storeManager.purchase(product)
                    }
                }
            }
            
        } message: {
            Text(LocalStrings.Alert.Text.purchaseFullVersionWarning)
        }

    }
    
}

