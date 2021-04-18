//
//  DebtorsListView.swift
//  Debts
//
//  Created by Sergei Volkov on 18.04.2021.
//

import SwiftUI

struct DebtorsListView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var debtorsDebt: DebtorsDebtsViewModel
//    @EnvironmentObject var addDebtVM: AddDebtViewModel
    
    var body: some View {
        
        NavigationView {
            
            List(debtorsDebt.debtors, id:\.self) { debtor in
                
                Button {
                    
                    AddDebtViewModel.shared.selectedDebtor = debtor
                    
                    //                    if let image = contact.imageData {
                    //                        if let userImage =  UIImage(data: image) {
                    //                            AddDebtViewModel.shared.image = userImage
                    //                        }
                    //                    }
                    
                    AddDebtViewModel.shared.checkDebtor()
                    
                    
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text(debtor.fullName)
                }
                
            }
            
            .navigationBarTitle(NSLocalizedString("Debtors list", comment: "nav title"))
        }
        
    }
}

struct DebtorsListView_Previews: PreviewProvider {
    static var previews: some View {
        DebtorsListView()
    }
}
