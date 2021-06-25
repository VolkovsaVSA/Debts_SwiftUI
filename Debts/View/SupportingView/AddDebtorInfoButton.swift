//
//  AddDebtorInfoButtonView.swift
//  Debts
//
//  Created by Sergei Volkov on 10.04.2021.
//

import SwiftUI

struct AddDebtorInfoButton: View {
    
    let title: String
    let buttonColor: Color
    let titleColor: Color
    var action: ()->()
    
    var body: some View {
        
        Button(action: {
            action()
        }, label: {
            Text(title)
                .frame(width: 160)
                .padding(6)
                .foregroundColor(titleColor)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundColor(buttonColor)
                )
        })
        .buttonStyle(PlainButtonStyle())
    }
}
