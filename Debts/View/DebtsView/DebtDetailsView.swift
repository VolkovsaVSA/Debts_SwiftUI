//
//  DebtDetailsView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct DebtDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    
    private var navTtile: LocalizedStringKey {
        return debt.debtorStatus == "debtor" ? LocalizedStringKey("Debt detail") : LocalizedStringKey("Credit detail")
    }
    
    @ObservedObject var debt: DebtCD
    
    var body: some View {
        
        Form {
            DebtDetailSection(debt: debt, isPeymentView: false, lastDateForAddedPaymentview: nil)
            PaymentsView(debt: debt, isEditable: false)
        }
        .listStyle(.grouped)

        .onDisappear() {
            DebtsViewModel.shared.selectedDebt = nil
            dismiss()
        }
        .navigationTitle(navTtile)
  
        .onAppear {
//            UITableView.appearance().backgroundColor = .clear
        }
    }
    
}
