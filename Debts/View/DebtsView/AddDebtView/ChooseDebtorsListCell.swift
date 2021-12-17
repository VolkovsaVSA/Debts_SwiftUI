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
                    HStack {
                        Text(debtor.fullName)
                        Spacer()
                        if let debts = debtor.debts {
                            Text("debts: ")
                            Text(debts.count.description)
                        }
                    }
                    if let phone = debtor.phone,
                       phone.count != 0
                    {
                        Text(phone)
                            .fontWeight(.thin)
                    }
                }
            }
            

        }
    }
}
