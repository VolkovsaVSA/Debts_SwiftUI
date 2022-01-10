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
        Section(header: Text(LocalStrings.Views.Settings.purchases).fontWeight(.semibold).foregroundColor(.primary)) {
            Group {
                if isFullVersion {
                    HStack {
                        Spacer()
                        Text(LocalStrings.Views.Settings.youUseAFullVersion)
                        Spacer()
                    }
                    
                } else {
                    SettingsButton(title: LocalStrings.Views.Settings.purchaseFullVersion) {
                        showPurchaseWarning = true
                    }
                }

            }
        }
        .alert(LocalStrings.purchesingWarning(price: storeManager.priceFullVersion),
               isPresented: $showPurchaseWarning) {
            if let product = storeManager.products?.first {
                Button(LocalStrings.Button.purchase, role: .destructive) {
                    Task.init {
                        try await storeManager.purchase(product)
                    }
                }
            }
            
        } message: {
            Text(LocalStrings.Alert.Text.purchaseFullVersionWarning)
                .autocapitalization(.none)
        }

    }
    
}

