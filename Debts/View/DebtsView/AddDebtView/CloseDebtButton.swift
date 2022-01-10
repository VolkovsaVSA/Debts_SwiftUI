//
//  CloseDebtButton.swift
//  Debts
//
//  Created by Sergei Volkov on 26.11.2021.
//

import SwiftUI

struct CloseDebtButton: View {
    
    let action: ()->()
    
    var body: some View {
        Section {
            Button {
                action()
            } label: {
                Text(LocalStrings.Button.closeDebt)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.red)
                    )
            }
            .foregroundColor(.white)
            .buttonStyle(PlainButtonStyle())
        }
        .listRowBackground(
            Color.clear
        )
    }
}


