//
//  DebtorsListView.swift
//  Debts
//
//  Created by Sergei Volkov on 18.04.2021.
//

import SwiftUI

struct ChooseDebtorsListView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var debtorsDebt: DebtsViewModel
    @State private var lottieID = UUID()

    var body: some View {
        
        NavigationView {
            
            if debtorsDebt.debtors.isEmpty {
                EmptyDataAnimationView()
                    .id(lottieID)
                    .onAppear {
                        lottieID = UUID()
                    }
                    .navigationBarTitle(LocalStrings.NavBar.debtorsList)
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
                .navigationBarTitle(LocalStrings.NavBar.debtorsList)
            }
            
        }
        .navigationViewStyle(.stack)
    }
}
