//
//  PurchaseButton.swift
//  Debts
//
//  Created by Sergei Volkov on 14.12.2021.
//

import SwiftUI

struct SettingsButton: View {
    
    let title: String
    let action: ()->()
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
        }
    }
}

