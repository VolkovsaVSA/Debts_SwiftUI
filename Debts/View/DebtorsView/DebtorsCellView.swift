//
//  DebtorsCellView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct DebtorsCellView: View {
    
    @EnvironmentObject var debtorsDebt: DebtorsDebtsViewModel
    @State var item: Debt
    
    var body: some View {
        
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 70, height: 70, alignment: .center)
                .foregroundColor(Color(UIColor.systemGray))
                .background(Color(UIColor.white))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(item.debtor.fristName)
                    Text(item.debtor.familyName ?? "")
                }
                .lineLimit(1)
                .font(.system(size: 20, weight: .medium, design: .default))
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Total debt:")
                        Text(debtorsDebt.getAllAmountOfDebtsOneDebtor(debtor: item.debtor).description)
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

struct DebtorsCellView_Previews: PreviewProvider {
    static var previews: some View {
        DebtorsCellView(item: Debt(initialDebt: 100,
                                   balanceOfDebt: 100,
                                   isClosed: false,
                                   payments: [],
                                   debtor: Debtor(fristName: "Ivan",
                                                  familyName: "Ivanov",
                                                  phone: nil,
                                                  email: nil,
                                                  debtorStatus: DebtorStatus.debtor,
                                                  debts: []),
                                   currencyCode: "USD"))
            .environmentObject(DebtorsDebtsViewModel())
    }
}
