//
//  AddDebtView.swift
//  Debts
//
//  Created by Sergei Volkov on 09.04.2021.
//

import SwiftUI

struct AddDebtView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    @EnvironmentObject private var addDebtVM: AddDebtViewModel
    @EnvironmentObject private var debtsVM: DebtsViewModel
    
    @State private var refresh = UUID()
    @State private var closeDebtAlertPresent = false
    @State private var showActivityIndicator = false
   
    var body: some View {
        
        NavigationView {
            
            LoadingView(isShowing: $showActivityIndicator, text: "Image compression") {
                GeometryReader { geometryProxy in
                    ZStack {
                        Form {
                            DebtorInfoSectionView(showActivityIndicator: $showActivityIndicator)
                                .disabled(addDebtVM.editedDebt != nil)
                                .foregroundColor(addDebtVM.editedDebt != nil ? .gray : .primary)
                            DebtSectionView()
                            InterestSectionView()
                            PenaltySectionView()

                            if let editedDebt = addDebtVM.editedDebt {
                                EditedDebtSectionView(editedDebt: editedDebt)
                                CloseDebtButton {
                                    closeDebtAlertPresent = true
                                }
                            }
                        }

                        VStack {
                            Spacer()
                            CompareDebtsSheetView(debtorsMatching: Array(AddDebtViewModel.shared.debtorsMatching),
                                                  geometry: geometryProxy)
                                .modifier(CustomActionSheetModifire(width: geometryProxy.size.width,
                                                                    isShow: AddDebtViewModel.shared.showDebtorWarning))
                        }
                        .background(
                            (AddDebtViewModel.shared.showDebtorWarning ? Color.black.opacity(0.5) : Color.clear)
                                .edgesIgnoringSafeArea(.all)
    //                            .onTapGesture {
    //                                withAnimation {
    //                                    AddDebtViewModel.shared.showDebtorWarning.toggle()
    //                                }
    //                            }
                        )
                        .edgesIgnoringSafeArea(.bottom)
                    }
                    
                }
            }
        
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
            .alert("Close debt", isPresented: $closeDebtAlertPresent, actions: {
                Button("Close", role: .destructive) {
                    if let editedDebt = addDebtVM.editedDebt {
                        editedDebt.isClosed = true
                        editedDebt.closeDate = Date()
                        CDStack.shared.saveContext(context: viewContext)
                        addDebtVM.resetData()
                        debtsVM.refreshData()
                        dismiss()
                    }
                }
            }, message: {
                Text("This debt has a balance! Do you really want to close the outstanding debt?")
            })
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
                dismiss()
                CDStack.shared.container.viewContext.rollback()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    addDebtVM.resetData()
                }
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
        dismiss()
        debtsVM.refreshData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            addDebtVM.resetData()
        }
    }
}
