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
    @EnvironmentObject var debtorsDebt: DebtorsDebtsViewModel
    
    @State private var editDebt = DebtorsDebtsViewModel.shared.editDebtPush

    var body: some View {
        
        NavigationView {
            
            if debtorsDebt.debts.isEmpty {
                Text("No debts").font(.title)
                    .navigationTitle(LocalizedStringKey("Debts"))
            } else {
                ScrollView {
                    ForEach(debtorsDebt.debts) { debt in

                        ActionMenu(content: DebtsCellView(debt: debt),
                                   actionData: debtorsDebt.debtsMenuData(debt: debt))
                            .background(
                                NavigationLink(destination: debtorsDebt.selecetedView(),
                                               isActive: $debtorsDebt.debtDetailPush) {EmptyView()}
                            )
                        
                    }
                }
                .padding(.horizontal)
                .navigationTitle(LocalizedStringKey("Debts"))
                
//                .sheet(item: $debtorsDebt.sheet) { item in
//                    switch item {
//                    case .addDebtViewPresent:
//                        AddDebtView()
//                            .environmentObject(addDebtVM)
//                            .environmentObject(currencyListVM)
//                            .environmentObject(debtorsDebt)
//                    default: EmptyView()
//                    }
//                }
                
                .sheet(isPresented: $debtorsDebt.editDebtPush) {
                    AddDebtView()
                        .environmentObject(addDebtVM)
                        .environmentObject(currencyListVM)
                        .environmentObject(debtorsDebt)
                }
            }
            
        }
 
    }
    
    
    
}
//
//struct DebtsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DebtsView()
//            .environmentObject(DebtorsDebtsViewModel())
//    }
//}
