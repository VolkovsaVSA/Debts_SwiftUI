//
//  DebtDetailsView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct DebtDetailsView: View {
    
    let debt: DebtCD
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 6) {
            HStack {
//                Text(DebtorStatus.statusLocalize(status: debt.))
                Text(debt.debtor?.fullName ?? "")
                Spacer()
            }
            
        }
        .padding()
        
        
        
            .navigationTitle("Debt detail")
    }
}
//
//struct DebtDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DebtDetailsView(debt: Debt(initialDebt: 100,
//                                   balanceOfDebt: 100,
//                                   startDate: Date(),
//                                   endDate: Date(),
//                                   isClosed: false,
//                                   percentType: .perYear,
//                                   percent: 12,
//                                   percentAmount: nil,
//                                   payments: [],
//                                   debtor: Debtor(fristName: "Alex",
//                                                  familyName: "Bar",
//                                                  phone: nil,
//                                                  email: nil,
//                                                  debts: []),
//                                   currencyCode: "USD",
//                                   comment: nil, debtorStatus: DebtorStatus.debtor))
//    }
//}
