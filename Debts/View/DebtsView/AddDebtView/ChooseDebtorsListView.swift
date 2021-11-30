//
//  DebtorsListView.swift
//  Debts
//
//  Created by Sergei Volkov on 18.04.2021.
//

import SwiftUI

struct ChooseDebtorsListView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var debtorsDebt: DebtsViewModel

    var body: some View {
        
        NavigationView {
            
            if debtorsDebt.debtors.isEmpty {
                Text("No debtors").font(.title)
                    .navigationBarTitle(NSLocalizedString("Debtors list", comment: "nav title"))
            } else {
                List(debtorsDebt.debtors, id:\.self) { debtor in
                    
                    Button {
                        
                        AddDebtViewModel.shared.selectedDebtor = debtor
                        
                        //                    if let image = contact.imageData {
                        //                        if let userImage =  UIImage(data: image) {
                        //                            AddDebtViewModel.shared.image = userImage
                        //                        }
                        //                    }
                        
                        AddDebtViewModel.shared.checkDebtor()
                        dismiss()
                    } label: {
                        
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
                .navigationBarTitle(NSLocalizedString("Debtors list", comment: "nav title"))
            }
            
        }
        
    }
}
