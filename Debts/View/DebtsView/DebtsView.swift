//
//  DebtsView.swift
//  Debts
//
//  Created by Sergei Volkov on 07.04.2021.
//

import SwiftUI


struct DebtsView: View {
    
    @EnvironmentObject var addDebtVM: AddDebtViewModel
    @EnvironmentObject var currencyListVM: CurrencyViewModel
    @EnvironmentObject var debtsVM: DebtsViewModel
    
    
    var body: some View {
        
        NavigationView {
            
            if debtsVM.debts.isEmpty {
                Text("No debts").font(.title)
                    .navigationTitle(LocalizedStringKey("Debts"))
            } else {
                ScrollView {
                    ForEach(debtsVM.debts) { debt in
                        ActionMenu(content: DebtsCellView(debt: debt),
                                   actionData: debtsVM.debtsMenuData(debt: debt))
                            .background(
                                NavigationLink(destination: debtsVM.selecetedView(),
                                               isActive: $debtsVM.debtDetailPush) {EmptyView()}
                            )
                    }.id(UUID())
                }
                .padding(.horizontal)
                .navigationTitle(LocalizedStringKey("Debts"))
                
                .sheet(item: $debtsVM.debtSheet) { item in
                    switch item {
                    case .addDebtViewPresent:
                        AddDebtView()
                            .environmentObject(addDebtVM)
                            .environmentObject(currencyListVM)
                            .environmentObject(debtsVM)
                    case .debtPayment:
                        AddPaymentView()
                            .environmentObject(debtsVM)
                    default: EmptyView()
                    }
                }
 
            }
            
        }
 
    }
    
    
    
}
