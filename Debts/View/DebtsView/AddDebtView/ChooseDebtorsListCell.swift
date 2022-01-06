//
//  ChooseDebtorsListCell.swift
//  Debts
//
//  Created by Sergei Volkov on 06.12.2021.
//

import SwiftUI

struct ChooseDebtorsListCell: View {
    
    @ObservedObject var debtor: DebtorCD
    let handler: ()->()
    
    var body: some View {
        
        Button {
            handler()
        } label: {
            HStack {
                PersonImage(size: 40, image: debtor.image)
                VStack(alignment: .leading) {
                    Text(debtor.fullName)
                    if let phone = debtor.phone,
                       phone.count != 0
                    {
                        Text(phone)
                            .fontWeight(.thin)
                    }
                }
                Spacer()
                VStack(alignment: .trailing) {
                    if let debts = debtor.debts {
                        Text("debts: \(debts.count)")
                    }
                    Text("overdue: \(debtor.calclulateOverdueDebts())")
                        .foregroundColor(debtor.calclulateOverdueDebts() > 0 ? .red : .primary)
                }
            }
            

        }
    }
}
