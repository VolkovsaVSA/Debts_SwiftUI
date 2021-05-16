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


    var body: some View {
        
        NavigationView {
            
            Form {
                Section (header: addDebtVM.localDebtorStatus == 0 ? Text(DebtorStatus.debtorLocalString): Text(DebtorStatus.creditorLocalString)) {
                    Picker("", selection: $addDebtVM.localDebtorStatus) {
                        Text(DebtorStatus.debtorLocalString).tag(0)
                        Text(DebtorStatus.creditorLocalString).tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    VStack {
                        HStack {
                            Spacer()
                            
                            if let userImage = addDebtVM.image {
                                Image(uiImage: userImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .foregroundColor(.gray)
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            VStack(alignment: .trailing, spacing: 10) {
                                AddDebtorInfoButton(title: "From contacts",
                                                    buttonColor: AppSettings.accentColor,
                                                    titleColor: .white) {
                                    addDebtVM.sheetType = .contactPicker
                                }
                                AddDebtorInfoButton(title: "From debtors",
                                                    buttonColor: AppSettings.accentColor,
                                                    titleColor: .white) {
                                    addDebtVM.sheetType = .debtorsList
                                }
                            }

                        }
                        Group {
                            TextField("First name", text: $addDebtVM.firstName)
                            TextField("Family name", text: $addDebtVM.familyName)
                            TextField("Phone", text: $addDebtVM.phone)
                                .keyboardType(.phonePad)
                            TextField("Email", text: $addDebtVM.email)
                                .keyboardType(.emailAddress)
                        }
                        .padding(.top, 4)
                        .padding(.bottom, 6)

                    }
                }
                .internalBody.disabled(addDebtVM.debtorSectionDisable)

                Section(header: Text("Debt")) {
                    HStack {
                        Text("Initial debt")
                        TextField("Debt amount", text: $addDebtVM.debtAmount)
                            .keyboardType(.decimalPad)
                        NavigationLink(currencyVM.selectedCurrency.currencyCode, destination: CurrencyListView())
                            .frame(width: 60)
                    }

                    Group {
                        DatePicker("Start date", selection: $addDebtVM.startDate)
                        DatePicker("End date", selection: $addDebtVM.endDate)
                    }
                    .accentColor(AppSettings.accentColor)
                    HStack {
                        TextField("Percent", text: $addDebtVM.percent)
                        Picker("%", selection: $addDebtVM.selectedPercentType) {
                            ForEach(PercentType.allCases, id: \.self) { type in
                                Text(PercentType.percentTypeConvert(type: type))
                            }
                        }
                        .lineLimit(1)
                    }
                    TextField("Comment", text: $addDebtVM.comment)
                }
                
                
                if let editedDebt = addDebtVM.editedDebt {
                    Section {
                        VStack {
                            HStack {
                                Text("Balance of debt:")
                                    .fontWeight(.thin)
                                Spacer()
                                Text(currencyVM.currencyConvert(amount: editedDebt.fullBalance as Decimal, currencyCode: editedDebt.currencyCode))
                            }
                            AddDebtorInfoButton(title: "Add payment",
                                                buttonColor: AppSettings.accentColor,
                                                titleColor: .white) {
                                debtsVM.selectedDebt = editedDebt
                                debtsVM.addPaymentPush = true
                            }
                            .background(
                                NavigationLink(destination: AddPaymentView(),
                                               isActive: $debtsVM.addPaymentPush) {EmptyView()}
                            )
                        }
                        .padding(.bottom, 4)
                    }
                    
                    PaymentsView(debt: editedDebt, isEditable: true)
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
            
            .alert(item: $addDebtVM.alertType) { alert in
                switch alert {
                case .oneButtonInfo:
                    return Alert(
                        title: Text(addDebtVM.alertTitle),
                        message: Text(addDebtVM.alertMessage),
                        dismissButton: .cancel(Text("OK"))
                    )
                }
            }
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
        } else {
            if let debtor = addDebtVM.selectedDebtor {
                addDebtVM.updateDebtor(debtor: debtor)
                _ = addDebtVM.createDebt(debtor: debtor, currencyCode: currencyVM.selectedCurrency.currencyCode)
            } else {
                let debtor = addDebtVM.createDebtor()
                _ = addDebtVM.createDebt(debtor: debtor, currencyCode: currencyVM.selectedCurrency.currencyCode)
            }
        }

        CDStack.shared.saveContext(context: viewContext)
        debtsVM.refreshData()
        addDebtVM.resetData()
        presentationMode.wrappedValue.dismiss()
    }
}
