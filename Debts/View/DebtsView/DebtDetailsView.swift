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
                
                if debt.percent != 0 {
                    HStack {
                        Text("Percent:")
                        Text(debt.percent.description)
                        Text("%")
                        Text(PercentType.percentTypeConvert(type: PercentType(rawValue: Int(debt.percentType)) ?? .perYear))
                        Spacer()
                    }
                }
                
                
            }
            
            Section(header: Text("Payments")) {
                
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
