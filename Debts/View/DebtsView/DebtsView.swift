//
//  DebtsView.swift
//  Debts
//
//  Created by Sergei Volkov on 07.04.2021.
//

import SwiftUI



struct DebtsView: View {
    
    @EnvironmentObject var debtorsDebt: DebtorsDebtsViewModel

    var body: some View {
        
        NavigationView {
            
            if debtorsDebt.debts.isEmpty {
                Text("No debts").font(.title)
                    .navigationTitle(LocalizedStringKey("Debts"))
                
            } else {
                ScrollView {
                    ForEach(debtorsDebt.debts) { item in
                        
                        ActionMenu(content:
                                    NavigationLink(
                                        destination: DebtDetailsView(debt: item),
                                        isActive: $debtorsDebt.debtDetailPush,
                                        label: {
                                            DebtsCellView(debt: item)
                                        }),
                                   actionData: debtorsDebt.debtsMenuData(debt: item))
                    }
                }
                .navigationTitle(LocalizedStringKey("Debts"))
            }
            
        }
 
    }
    
    
    
}

struct DebtsView_Previews: PreviewProvider {
    static var previews: some View {
        DebtsView()
            .environmentObject(DebtorsDebtsViewModel())
    }
}
