//
//  DebtsView.swift
//  Debts
//
//  Created by Sergei Volkov on 07.04.2021.
//

import SwiftUI


struct DebtsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var addDebtVM: AddDebtViewModel
    @EnvironmentObject var currencyListVM: CurrencyViewModel
    @EnvironmentObject var debtsVM: DebtsViewModel
    @EnvironmentObject var currencyVM: CurrencyViewModel
    
    @State private var showingOptions = false
    @State private var isShowingMessages = false
    @State private var sortImageIcrease = false
    
    @StateObject var selectedSortObject: SortObject
    
    var body: some View {
        
        NavigationView {
            
            if debtsVM.debts.isEmpty {
                NoDataBanner(text: LocalizedStringKey("No debts"))
                    .navigationTitle(LocalizedStringKey("Debts"))
                    .modifier(BackgroundViewModifire())
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
                                debtsVM.deleteDebt(debt: debt)
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
                                debtsVM.selectedDebt = debt
                                showingOptions = true
                            } label: {
                                Label("Connection", systemImage: "message")
                            }.tint(Color(UIColor.systemGray))

                        }
                        
                    }
                    
                }
                .listStyle(.plain)
                .modifier(BackgroundViewModifire())
                
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
                    case .sms:
                        MessageComposeView(recipients: [debtsVM.selectedDebt?.debtor?.phone ?? ""], body: String(localized: "\(debtsVM.selectedDebt?.debtor?.fullName ?? "") hello!...")) { messageSent in
                            print("MessageComposeView with message sent? \(messageSent)")
                        }
                    default: EmptyView()
                    }
                }
                
                .confirmationDialog("How do you want to contact \(debtsVM.selectedDebt?.debtor?.fullName ?? "")?" , isPresented: $showingOptions, titleVisibility: .visible) {

                    Button("Call", role: .none) {
                        guard let phone = debtsVM.selectedDebt?.debtor?.phone else { return }
                        ConnectionManager.makeACall(number: phone)
                    }
                    Button("Send SMS", role: .none) {
                        debtsVM.debtSheet = .sms
                    }
                    Button("Share", role: .none) {
                        guard let debt = debtsVM.selectedDebt else { return }
                        ConnectionManager.share(selectedDebt: debt)
                    }

                }
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Picker(SortType.localizedSortType(selectedSortObject.selected), selection: $selectedSortObject.selected) {
                            ForEach(selectedSortObject.sortArray, id: \.self) { item in
                                Text(SortType.localizedSortType(item)).tag(item)
                            }
                           
                        }
                        .pickerStyle(.menu)
//                        .accentColor(Color.white)
                    }
                    
                }
                
            }
            
        }
 
    }
    
    
    
}
