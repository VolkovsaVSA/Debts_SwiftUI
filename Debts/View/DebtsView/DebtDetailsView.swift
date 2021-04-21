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
            Section(header: Text("Debt")) {
                HStack {
                    Text("\(DebtorStatus.statusCDLocalize(status: debt.debtorStatus)):")
                    Text(debt.debtor?.fullName ?? "no debtor")
                    Spacer()
                }
                HStack {
                    Text("Initial debt:")
                    Text(currencyVM.currencyConvert(amount: debt.initialDebt as Decimal, currencyCode: debt.currencyCode))
                    Spacer()
                }
                HStack {
                    Text("Balance:")
                    Text(currencyVM.currencyConvert(amount: debt.balanceOfDebt as Decimal, currencyCode: debt.currencyCode))
                    Spacer()
                }
                HStack {
                    Text("Start date:")
                    Text(debt.laclizeStartDateAndTime)
                    Spacer()
                }
                HStack {
                    Text("End date:")
                    Text(debt.laclizeEndDateAndTime)
                    Spacer()
                }
            }
            
            
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
