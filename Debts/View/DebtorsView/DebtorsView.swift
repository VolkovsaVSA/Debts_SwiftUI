//
//  DebtorsView.swift
//  Debts
//
//  Created by Sergei Volkov on 13.04.2021.
//

import SwiftUI

struct DebtorsView: View {
    
    @EnvironmentObject var debtorsDebt: DebtorsDebtsViewModel
    
    var body: some View {
        
        NavigationView {
            
            if debtorsDebt.debtors.isEmpty {
                Text("No debtors").font(.title)
                    .navigationTitle(LocalizedStringKey("Debtors"))
            } else {
                ScrollView {
                    ForEach(debtorsDebt.debtors) { debtor in
                        ActionMenu(content:
                                        NavigationLink(
                                            destination: DebtorDetailView(debtor: debtor),
                                            isActive: $debtorsDebt.debtorDetailPush,
                                            label: {
                                                DebtorsCellView(debtor: debtor)
                                            }),
                                   actionData: debtorsDebt.debtorsMenuData(debtor: debtor))
                    }
                }
                .padding(.horizontal)
                .navigationTitle(LocalizedStringKey("Debtors"))
            }

        }
        
    }
}

struct DebtorsView_Previews: PreviewProvider {
    static var previews: some View {
        DebtorsView()
            .environmentObject(DebtorsDebtsViewModel())
    }
}
