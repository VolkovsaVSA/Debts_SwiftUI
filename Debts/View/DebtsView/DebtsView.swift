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
    @EnvironmentObject var currencyVM: CurrencyViewModel
    
    
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
                    }.id(UUID())
                    .background(
                        NavigationLink(destination: debtsVM.selecetedView(),
                                       isActive: $debtsVM.debtDetailPush) {EmptyView()}
                    )
                    

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
                        AddPaymentView(debt: debtsVM.selectedDebt!, isEditableDebt: false)
                            .environmentObject(debtsVM)
                            .environmentObject(currencyVM)
                    default: EmptyView()
                    }
                }
 
            }
            
        }
 
    }
    
    
    
}
