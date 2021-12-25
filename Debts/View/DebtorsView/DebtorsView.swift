//
//  DebtorsView.swift
//  Debts
//
//  Created by Sergei Volkov on 13.04.2021.
//

import SwiftUI

struct DebtorsView: View {
    
    @EnvironmentObject private var debtsVM: DebtsViewModel
    @FetchRequest(fetchRequest: DebtorCD.fetchRequest(), animation: .default)
    private var debtors: FetchedResults<DebtorCD>
    
    @StateObject var selectedSortDebtorsObject: SortDebtorsObject
    @State private var alertPresent = false
    @State private var addDebtorPresent = false
    @State private var refreshedID = UUID()
    
    var body: some View {
        
        NavigationView {
            
            if debtors.isEmpty {
                NoDataBanner(text: LocalizedStringKey("No debtors"))
//                    .modifier(BackgroundViewModifire())
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

                }
                .listStyle(.plain)
                .navigationTitle(LocalizedStringKey("Debtors"))
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        Menu {
                            ForEach(selectedSortDebtorsObject.sortArray) { item in
                                Button {
                                    selectedSortDebtorsObject.selected = item
                                    debtors.sortDescriptors = selectedSortDebtorsObject.convertSortDescriptors
                                } label: {
                                    HStack {
                                        Image(systemName: selectedSortDebtorsObject.selected == item ? "checkmark" : "")
                                        Text(SortDebtorsType.localizedSortType(item))
                                    }
                                }
                            }
                        } label: {
                            SortImageForLabel()
                        }

                    }
                }
            }

                
        }

    }

}
