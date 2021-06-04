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
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 4)
                        .padding(.bottom, 6)
                    }
                }
                .internalBody.disabled(addDebtVM.debtorSectionDisable)

                Section(header: Text("Debt")) {
                    HStack {
                        TextField("Enter initial debt", text: $addDebtVM.debtAmount)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                        Button {
                            addDebtVM.selectCurrencyPush = true
                        } label: {
                            Text(currencyVM.selectedCurrency.currencyCode)
                                .foregroundColor(AppSettings.accentColor)
                                .frame(width: 56)
                        }
                        .padding(.trailing, 4)
                        .buttonStyle(PlainButtonStyle())
                        .background(
                            NavigationLink(destination: CurrencyListView(), isActive: $addDebtVM.selectCurrencyPush) {EmptyView()}
                                
                        )
                            
                    }
                    
                    TextField("Comment", text: $addDebtVM.comment)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    VStack {
                        DatePicker("Start",
                                   selection: $addDebtVM.startDate,
                                   in: ...addDebtVM.endDate)
                        DatePicker("End",
                                   selection: $addDebtVM.endDate,
                                   in: addDebtVM.startDate...)
                    }
                    .font(.system(size: 17, weight: .thin, design: .default))
                    .accentColor(AppSettings.accentColor)
                    
                    
                }
                
                Section(header: Toggle("Interest", isOn: $addDebtVM.isInterest.animation()), footer: addDebtVM.isInterest ? AnyView(Text("Interest is charged either on the original amount of the debt or on the balance of the debt.")) : AnyView(EmptyView()) ) {
                    
                    if addDebtVM.isInterest {
                        HStack {
                            TextField("Interest", text: $addDebtVM.percent)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Spacer()
                            Picker("% \(PercentType.percentTypeConvert(type: addDebtVM.selectedPercentType))", selection: $addDebtVM.selectedPercentType) {
                                ForEach(PercentType.allCases, id: \.self) { type in
                                    Text(PercentType.percentTypeConvert(type: type))
                                }
                            }
                            .modifier(SimpleButtonModifire(textColor: .white,
                                                           buttonColor: AppSettings.accentColor,
                                                           frameWidth: 140))
                            .pickerStyle(MenuPickerStyle())
                            .lineLimit(1)
                        }
                        
                        HStack {
                            Text("Interest calculation method")
                                .lineLimit(2)
                                .font(.system(size: 17, weight: .thin, design: .default))
                            Spacer()
                            Picker(addDebtVM.convertedPercentBalanceType, selection: $addDebtVM.percentBalanceType) {
                                Text(LocalizedStrings.Views.AddDebtView.initialDebt).tag(0)
                                Text(LocalizedStrings.Views.AddDebtView.balanseOfDebt).tag(1)
                            }
                            .modifier(SimpleButtonModifire(textColor: .white,
                                                           buttonColor: AppSettings.accentColor,
                                                           frameWidth: 140))
                            .pickerStyle(MenuPickerStyle())
                        }
           
                    }
                    
                }

                
                if let editedDebt = addDebtVM.editedDebt {
                    Section {
                        
                        VStack {
                            HStack {
                                Text("Balance of debt:")
                                    .fontWeight(.thin)
                                Spacer()
                                Text(currencyVM.currencyConvert(amount: editedDebt.fullBalance as Decimal,
                                                                currencyCode: editedDebt.currencyCode))
                            }.id(refresh)
                            
                            if addDebtVM.isInterest {
                                HStack {
                                    Text("Interest charges:")
                                        .fontWeight(.thin)
                                    Spacer()
                                    Text(currencyVM.currencyConvert(amount: editedDebt.calculatePercentAmountFunc(balanceType: addDebtVM.percentBalanceType),
                                                                    currencyCode: editedDebt.currencyCode))
                                }.id(refresh)
                            }
                            
                            Button(action: {
                                addDebtVM.addPaymentPush = true
                            }, label: {
                                Text("Add payment")
                                    .frame(width: 160)
                                    .padding(6)
                                    .foregroundColor(.white)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .foregroundColor(AppSettings.accentColor)
                                            .background(
                                                NavigationLink(destination: AddPaymentView(debt: editedDebt, isEditableDebt: true),
                                                               isActive: $addDebtVM.addPaymentPush) {EmptyView()}
                                            )
                                    )
                            })
                            .buttonStyle(PlainButtonStyle())
                            
                        }
                        .padding(.bottom, 4)
                    }
                    
                    PaymentsView(debt: editedDebt, isEditable: true)
                        .onReceive(editedDebt.objectWillChange) { _ in
                            refresh = UUID()
                        }
                        
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
