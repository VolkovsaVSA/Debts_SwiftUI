//
//  DebtorsView.swift
//  Debts
//
//  Created by Sergei Volkov on 13.04.2021.
//

import SwiftUI

struct DebtorsView: View {
    
    @EnvironmentObject var debtsVM: DebtsViewModel
    
    @State var alertPresent = false
    @State var addDebtorPresent = false
    
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
                                    alertPresent = true
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                Button(role: .destructive) {
                                    
                                } label: {
                                    Label("Edit", systemImage: "square.and.pencil")
                                }.tint(.purple)
                            }
                            .alert(String(localized: "Delete debtor?"), isPresented: $alertPresent) {
                                Button("Delete debtor", role: .destructive) {
                                    withAnimation {
                                        debtsVM.deleteDebtor(debtor: debtor)
                                    }
                                }
                            } message: {
                                Text("If you delete debtor all his debts will be deleted too (include closed debts from history)!")
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
