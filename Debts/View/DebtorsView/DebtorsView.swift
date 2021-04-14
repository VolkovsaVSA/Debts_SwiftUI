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
            ScrollView {
                ForEach(debtorsDebt.debts) { item in
                    DebtorsCellView(item: item)
                }
            }
            .navigationTitle(LocalizedStringKey("Debtors"))
        }
        
    }
}

struct DebtorsView_Previews: PreviewProvider {
    static var previews: some View {
        DebtorsView()
            .environmentObject(DebtorsDebtsViewModel())
    }
}
