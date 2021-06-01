//
//  DebtDetailsView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct DebtDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var debt: DebtCD
    
    var body: some View {
        
        Form {
            DebtDetailSection(debt: debt)
            PaymentsView(debt: debt, isEditable: false)
        }
        .onDisappear() {
            DebtsViewModel.shared.selectedDebt = nil
            presentationMode.wrappedValue.dismiss()
        }
        .navigationTitle("Debt detail")
    }
    
}
