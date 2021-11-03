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
                        Text(debtor.fullName)
                    }
                    
                }
                .navigationBarTitle(NSLocalizedString("Debtors list", comment: "nav title"))
            }
            
        }
        
    }
}
