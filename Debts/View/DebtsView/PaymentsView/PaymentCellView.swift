//
//  DebtPaymentCellView.swift
//  Debts
//
//  Created by Sergei Volkov on 16.05.2021.
//

import SwiftUI

struct PaymentCellView: View {
    
    @EnvironmentObject var currencyVM: CurrencyViewModel
    @ObservedObject var payment: PaymentCD
    @ObservedObject var debt: DebtCD
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(payment.localizePaymentDateAndTime)
                .font(.system(size: 14, weight: .thin, design: .default))
            Text(currencyVM.currencyConvert(amount: payment.paymentDebt as Decimal, currencyCode: debt.currencyCode))
                .fontWeight(.medium)
            if payment.comment != "" {
                HStack {
                    Text("Comment:")
                        .font(.system(size: 14, weight: .light, design: .default))
                    Text(payment.comment)
                        .font(.system(size: 14, weight: .thin, design: .default))
                }
            }
        }
    }
}


