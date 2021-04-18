//
//  DebtorsCellView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct DebtorsCellView: View {
    
    @EnvironmentObject var debtorsDebt: DebtorsDebtsViewModel
    
    @State var debtor: DebtorCD
    
    var body: some View {
        
        HStack {
            PersonImage()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(debtor.fullName)
                    .lineLimit(2)
                    .font(.system(size: 20, weight: .medium, design: .default))
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Total debt:")
                        Text(debtor.totalDebt.description)
                            .font(.system(size: 20, weight: .bold, design: .default))
                    }
                    
                    Text("(include interest)")
                        .font(.system(size: 10, weight: .light, design: .default))
                }
                
            }
            
            
            Spacer()
        }
        .modifier(CellModifire())
    }
}

//struct DebtorsCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        DebtorsCellView(item: Debt(initialDebt: 100,
//                                   balanceOfDebt: 100,
//                                   isClosed: false,
//                                   payments: [],
//                                   debtor: Debtor(fristName: "Ivan",
//                                                  familyName: "Ivanov",
//                                                  phone: nil,
//                                                  email: nil,
//                                                  debts: []),
//                                   currencyCode: "USD",
//                                   debtorStatus: DebtorStatus.debtor))
//            .environmentObject(DebtorsDebtsViewModel())
//    }
//}
