//
//  AddDebtView.swift
//  Debts
//
//  Created by Sergei Volkov on 09.04.2021.
//

import SwiftUI

struct AddDebtView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var currencyVM: CurrencyViewModel
    @EnvironmentObject var addDebtVM: AddDebtViewModel
    @EnvironmentObject var debtsVM: DebtsViewModel
    
    @State var refresh = UUID()

    var body: some View {
        
        NavigationView {
            
            Form {
                
                DebtorInfoSectionView()
                DebtSectionView()
                InterestSectionView()
                PenaltySectionView()

                if let editedDebt = addDebtVM.editedDebt {
                    EditedDebtSectionView(editedDebt: editedDebt)
                }
                
                    
            }
            .listStyle(InsetGroupedListStyle())
            
            .onAppear() {
                if addDebtVM.isSelectedCurrencyForEditableDebr {
                    addDebtVM.isSelectedCurrencyForEditableDebr = false
                } else {
                    addDebtVM.checkEditableDebt()
                }
            }
            
            .modifier(OneButtonAlert(title: addDebtVM.alertTitle,
                                     text: addDebtVM.alertMessage,
                                     alertType: addDebtVM.alertType))
            
            .sheet(item: $addDebtVM.sheetType) { sheet in
                switch sheet {
                case .contactPicker:
                    EmbeddedContactPicker()
                case .debtorsList:
                    ChooseDebtorsListView()
                        .environmentObject(DebtsViewModel())
                        .environmentObject(AddDebtViewModel())
                default: EmptyView()
                }
            }
            .modifier(CancelSaveNavBar(navTitle:  addDebtVM.navTitle,
                                       cancelAction: {
                                        CDStack.shared.container.viewContext.rollback()
                                        addDebtVM.resetData()
                                        presentationMode.wrappedValue.dismiss()
                                       },
                                       saveAction: {
                                        adddebt()
                                       }, noCancelButton: false)
            )

        }
        
    }
    
    private func adddebt() {
        
        if addDebtVM.checkFirstName() {
            return
        }
        if addDebtVM.checkDebtAmount() {
            return
        }
  
        if let debt = addDebtVM.editedDebt {
            addDebtVM.updateDebt(debt: debt, currencyCode: currencyVM.selectedCurrency.currencyCode)
            
            if let id = debt.id {
                NotificationManager.removeNotifications(identifiers: [id.uuidString])
            }
            NotificationManager.sendNotificationOfEndDebt(debt: debt)
            
        } else {
            
            var debtor: DebtorCD!
            
            if addDebtVM.selectedDebtor != nil {
                debtor = addDebtVM.selectedDebtor!
                addDebtVM.updateDebtor(debtor: debtor)
            } else {
                debtor = addDebtVM.createDebtor()
            }
            
            let debt = addDebtVM.createDebt(debtor: debtor, currencyCode: currencyVM.selectedCurrency.currencyCode)
            NotificationManager.sendNotificationOfEndDebt(debt: debt)
        }

        CDStack.shared.saveContext(context: viewContext)
        debtsVM.refreshData()
        addDebtVM.resetData()
        presentationMode.wrappedValue.dismiss()
    }
}
