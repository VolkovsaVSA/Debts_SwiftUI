//
//  DebtDetailsView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct DebtDetailsView: View {
    
    @EnvironmentObject var currencyVM: CurrencyViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var debt: DebtCD
    
    var body: some View {
        
        Form {
            DebtDatailSection(debt: debt)
            
            Section(header: Text("Payments")) {
                List {
                    ForEach(debt.allPayments, id:\.self) { payment in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(currencyVM.currencyConvert(amount: payment.amount as Decimal, currencyCode: debt.currencyCode))
                            Text(payment.localizePaymentDateAndTime)
                                .font(.system(size: 14, weight: .thin, design: .default))
                        }
                    }
                }
            }
            
        }
        .onDisappear() {
            DebtorsDebtsViewModel.shared.selectedDebt = nil
            presentationMode.wrappedValue.dismiss()
        }
        
            .navigationTitle("Debt detail")
    }
}
