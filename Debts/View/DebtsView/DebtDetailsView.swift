//
//  DebtDetailsView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct DebtDetailsView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    
    private var navTtile: LocalizedStringKey {
        return debt.debtorStatus == "debtor" ? LocalizedStringKey("Debt detail") : LocalizedStringKey("Credit detail")
    }
    
    @ObservedObject var debt: DebtCD
    
    var body: some View {
        
        Form {
            DebtDetailSection(debt: debt, isPeymentView: false)
                .modifier(DebtDetailCellModifire())
            PaymentsView(debt: debt, isEditable: false)
                .modifier(DebtDetailCellModifire())
        }
        .onDisappear() {
            DebtsViewModel.shared.selectedDebt = nil
            dismiss()
        }
        .navigationTitle(navTtile)
        .listStyle(.plain)
        .modifier(BackgroundViewModifire())
        
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
        }
    }
    
}
