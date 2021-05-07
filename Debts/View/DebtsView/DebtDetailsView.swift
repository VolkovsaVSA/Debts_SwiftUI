//
//  DebtDetailsView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct DebtDetailsView: View {
    
    @EnvironmentObject var currencyVM: CurrencyViewModel
    
    @ObservedObject var debt: DebtCD
    
    var body: some View {
        
        Form {
            DebtDatailSection(debt: debt)
            
            Section(header: Text("Payments")) {
                List {
                    ForEach(debt.allPayments, id:\.self) { payment in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(payment.amount.description)
                            Text(payment.localizePaymentDateAndTime)
                        }
                    }
                }
            }
            
        }
        .onDisappear() {
            DebtorsDebtsViewModel.shared.selectedDebt = nil
        }
        
            .navigationTitle("Debt detail")
    }
}
//
//struct DebtDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DebtDetailsView(debt: CDStack.shared.fetchDebts().first ?? DebtCD(context: CDStack.shared.container.viewContext))
//            .environment(\.managedObjectContext, CDStack.shared.container.viewContext)
//    }
//}
