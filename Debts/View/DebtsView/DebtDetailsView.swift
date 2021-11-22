//
//  DebtDetailsView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct DebtDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var debt: DebtCD
    
    var body: some View {
        
        Form {
            DebtDetailSection(debt: debt, isPeymentView: false)
            PaymentsView(debt: debt, isEditable: false)
        }
        .onDisappear() {
            DebtsViewModel.shared.selectedDebt = nil
            dismiss()
        }
        .navigationTitle("Debt detail")
    }
    
}
