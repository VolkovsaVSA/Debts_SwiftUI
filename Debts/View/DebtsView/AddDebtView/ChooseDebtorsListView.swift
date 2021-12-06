//
//  DebtorsListView.swift
//  Debts
//
//  Created by Sergei Volkov on 18.04.2021.
//

import SwiftUI

struct ChooseDebtorsListView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var debtorsDebt: DebtsViewModel

    var body: some View {
        
        NavigationView {
            
            if debtorsDebt.debtors.isEmpty {
                Text("No debtors").font(.title)
                    .navigationBarTitle(NSLocalizedString("Debtors list", comment: "nav title"))
            } else {
                List(debtorsDebt.debtors, id:\.self) { debtor in
                    ChooseDebtorsListCell(debtor: debtor) {
                        AddDebtViewModel.shared.selectedDebtor = debtor
                        AddDebtViewModel.shared.checkDebtor()
                        dismiss()
                    }
                    .modifier(CellModifire(frameMinHeight: 20, useShadow: true))
                }
                .listStyle(.plain)
                .modifier(BackgroundViewModifire())
                .navigationBarTitle(NSLocalizedString("Debtors list", comment: "nav title"))
            }
            
        }
        
    }
}
