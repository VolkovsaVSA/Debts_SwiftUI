//
//  DebtorsView.swift
//  Debts
//
//  Created by Sergei Volkov on 13.04.2021.
//

import SwiftUI

struct DebtorsView: View {
    
    @EnvironmentObject var debtsVM: DebtsViewModel
    
    @FetchRequest(
      entity: DebtorCD.entity(),
      sortDescriptors: [
        NSSortDescriptor(keyPath: \DebtorCD.familyName, ascending: true),
        NSSortDescriptor(keyPath: \DebtorCD.firstName, ascending: true),
      ]
    )
    var debtors: FetchedResults<DebtorCD>
    
    @State var alertPresent = false
    @State var addDebtorPresent = false
    
    var body: some View {
        
        NavigationView {
            
            if debtors.isEmpty {
                Text("No debtors").font(.title)
                    .modifier(BackgroundViewModifire())
                    .navigationTitle(LocalizedStringKey("Debtors"))
            } else {

                List {
                    ForEach(debtors) { debtor in
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
//                    .listRowSeparator(.hidden)
//                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .modifier(BackgroundViewModifire())
                
                .navigationTitle(LocalizedStringKey("Debtors"))

            }

                
        }

    }
}
