//
//  DebtorsView.swift
//  Debts
//
//  Created by Sergei Volkov on 13.04.2021.
//

import SwiftUI

struct DebtorsView: View {
    
    @EnvironmentObject var debtsVM: DebtsViewModel
    
    var body: some View {
        
        NavigationView {
            
            if debtsVM.debtors.isEmpty {
                Text("No debtors").font(.title)
                    .navigationTitle(LocalizedStringKey("Debtors"))
            } else {

                List {
                    ForEach(debtsVM.debtors) { debtor in
                        DebtorsCellView(debtor: debtor)
                            
                            .background(
                                NavigationLink(destination: DebtorDetailView(debtor: debtor)) {EmptyView()}
                                    .opacity(0)
                            )
                        
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    withAnimation {
                                        debtsVM.deleteDebtor(debtor: debtor)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        
                    }
                    .listRowSeparator(.hidden)
                    
                }
                .listStyle(.inset)
                .navigationTitle(LocalizedStringKey("Debtors"))
            }

               
        }
    }
}
