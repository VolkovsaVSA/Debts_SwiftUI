//
//  DebtsView.swift
//  Debts
//
//  Created by Sergei Volkov on 07.04.2021.
//

import SwiftUI


struct DebtsView: View {

    @EnvironmentObject private var addDebtVM: AddDebtViewModel
    @EnvironmentObject private var currencyListVM: CurrencyViewModel
    @EnvironmentObject private var debtsVM: DebtsViewModel
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    
    @State private var showingOptions = false
    @State private var isShowingMessages = false
    @State private var sortImageIcrease = false
    @State private var lottieID = UUID()
    
    @StateObject var selectedSortObject: SortObject
    
    var body: some View {
        
        NavigationView {
            
            if debtsVM.debts.isEmpty {
                LottieContainerView()
                    .id(lottieID)
                    .onAppear {
                        lottieID = UUID()
                    }
                    .navigationTitle(LocalizedStringKey("Debts"))
            } else {

                List {
                    ForEach(debtsVM.debts) { debt in
                        
                        DebtsCellView(debt: debt)
                            .zIndex(1)
                            .id(debtsVM.refreshID)
                            .modifier(CellModifire(frameMinHeight: AppSettings.cellFrameMinHeight, useShadow: true))
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
                            }
                            .tint(.purple)
                            
                            Button(role: .none) {
                                debtsVM.selectedDebt = debt
                                debtsVM.debtSheet = .debtPayment
                            } label: {
                                Label("Payment", systemImage: "dollarsign.circle")
                            }
                            .tint(.green)
                           
                        }
                        
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            
                            Button {
                                debtsVM.selectedDebt = debt
                                showingOptions = true
                            } label: {
                                Label("Connection", systemImage: "message")
                            }
                            .tint(Color(UIColor.systemGray))

                        }
                        
                    }
                    
                }
                .listStyle(.plain)
//                .modifier(BackgroundViewModifire())
                
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
                        
                        Menu {
                            ForEach(selectedSortObject.sortArray) { item in
                                Button {
                                    selectedSortObject.selected = item
                                } label: {
                                    HStack {
                                        Image(systemName: selectedSortObject.selected == item ? "checkmark" : "")
                                        Text(DebtSortType.localizedSortType(item))
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
