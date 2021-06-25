//
//  DebtsView.swift
//  Debts
//
//  Created by Sergei Volkov on 07.04.2021.
//

import SwiftUI


struct DebtsView: View {
    
    @EnvironmentObject var addDebtVM: AddDebtViewModel
    @EnvironmentObject var currencyListVM: CurrencyViewModel
    @EnvironmentObject var debtsVM: DebtsViewModel
    @EnvironmentObject var currencyVM: CurrencyViewModel
    
    
    var body: some View {
        
        NavigationView {
            
            if debtsVM.debts.isEmpty {
                Text("No debts").font(.title)
                    .navigationTitle(LocalizedStringKey("Debts"))
            } else {

                List {
                    
                    ForEach(debtsVM.debts) { debt in
                        
                        DebtsCellView(debt: debt)
                            .id(UUID())
                            .background(
                                NavigationLink(destination: DebtDetailsView(debt: debt)) {EmptyView()}
                                    .opacity(0)
                            )
                        
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            
                            Button(role: .destructive) {
                                
                                withAnimation {
                                    debtsVM.deleteDebt(debt: debt)
                                }
                                
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                            Button(role: .none) {
                                debtsVM.debtSheet = .addDebtViewPresent
                                addDebtVM.editedDebt = debt
                            } label: {
                                Label("Edit", systemImage: "square.and.pencil")
                            }.tint(.purple)
                            
                            Button(role: .none) {
                                
                                debtsVM.selectedDebt = debt
                                debtsVM.debtSheet = .debtPayment
                                
                            } label: {
                                Label("Payment", systemImage: "dollarsign.circle")
                            }.tint(.green)
                           
                        }
                        
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button {
                                
                            } label: {
                                Label("Regular notification", systemImage: "app.badge")
                            }

                        }
                    }
                    .listRowSeparator(.hidden)
                    
                }
                .listStyle(.inset)
//                .listStyle(.sidebar)
                
                .navigationTitle(LocalizedStringKey("Debts"))
                
                .sheet(item: $debtsVM.debtSheet) { item in
                    switch item {
                    case .addDebtViewPresent:
                        AddDebtView()
                            .environmentObject(addDebtVM)
                            .environmentObject(currencyListVM)
                            .environmentObject(debtsVM)
                    case .debtPayment:
                        AddPaymentView(debt: debtsVM.selectedDebt!, isEditableDebt: false)
                            .environmentObject(debtsVM)
                            .environmentObject(currencyVM)
                    default: EmptyView()
                    }
                }
 
            }
            
            
        }
 
    }
    
    
    
}
