//
//  DebtorsView.swift
//  Debts
//
//  Created by Sergei Volkov on 13.04.2021.
//

import SwiftUI

struct DebtorsView: View {
    
    @EnvironmentObject private var debtsVM: DebtsViewModel
    @FetchRequest(
      entity: DebtorCD.entity(),
      sortDescriptors:
        SortDebtorsObject.shared.sortDescriptors
//      [
//      NSSortDescriptor(keyPath: \DebtorCD.firstName, ascending: true),
//      NSSortDescriptor(keyPath: \DebtorCD.familyName, ascending: true),
//      ]
    )
    private var debtors: FetchedResults<DebtorCD>
    
    @StateObject var selectedSortDebtorsObject: SortDebtorsObject
    @State private var alertPresent = false
    @State private var addDebtorPresent = false
    
    @State private var refreshedID = UUID()
    
    var body: some View {
        
        NavigationView {
            
            if debtors.isEmpty {
                NoDataBanner(text: LocalizedStringKey("No debtors"))
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
//                .id(refreshedID)
                .listStyle(.plain)
                .modifier(BackgroundViewModifire())
                .navigationTitle(LocalizedStringKey("Debtors"))
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        Menu {
                            ForEach(selectedSortDebtorsObject.sortArray, id: \.self) { item in
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
//                .id(refreshedID)

            }

                
        }

    }
    
//    private func sortDebts() {
//        switch selectedSortDebtorsObject.selected.type {
//            case .firstName:
////                sortDescriptors = createSortDescriptors(reversed: false, isDecrease: selected.isDecrease)
//                debtors.sort {$0.firstName}
//                
//            case .familyName:
////                sortDescriptors = createSortDescriptors(reversed: true, isDecrease: selected.isDecrease)
//                
//                
//        }
//        
////        refreshedID = UUID()
//        
//        DispatchQueue.main.async {
//            UserDefaults.standard.set(self.selected.type.rawValue, forKey: UDKeys.sortDebtorsType)
//            UserDefaults.standard.set(self.selected.isDecrease, forKey: UDKeys.sortDebtorsDecrease)
//        }
//    }
}
