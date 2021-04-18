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
    @EnvironmentObject var currencyListVM: CurrencyListViewModel
    @EnvironmentObject var addDebtVM: AddDebtViewModel
    @EnvironmentObject var debtorsDebt: DebtorsDebtsViewModel
    
    @State private var refreshingID = UUID()
    
    var body: some View {
        
        NavigationView {
            
            List {
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
                            TextField("Email", text: $addDebtVM.email)
                        }
                        .padding(.top, 4)
                        .padding(.bottom, 6)

                    }
                }

                Section(header: Text("Debt")) {
                    HStack {
                        TextField("Debt amount", text: $addDebtVM.debtAmount)
                        NavigationLink(currencyListVM.selectedCurrency.currencyCode, destination: CurrencyListView())
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
                        }.lineLimit(1)
                    }
                    TextField("Comment", text: $addDebtVM.comment)
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            
            
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
                    DebtorsListView()
                        .environmentObject(DebtorsDebtsViewModel())
                        .environmentObject(AddDebtViewModel())
                default: EmptyView()
                }
            }

            
            .navigationBarItems(leading:
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Text("Cancel")
                                            .frame(width: 80)
                                            .foregroundColor(.white)
                                            .padding(4)
                                            .background(Color(UIColor.systemGray2))
                                            .cornerRadius(8)
                                    }),

                                trailing:
                                    
                                    Button(action: {

                                        adddebt()

                                    }, label: {
                                        Text("SAVE")
                                            .frame(width: 80)
                                            .foregroundColor(.white)
                                            .padding(4)
                                            .background(AppSettings.accentColor)
                                            .cornerRadius(8)
                                    })
                                    
                                    
            )
            .navigationTitle(NSLocalizedString("Add debt", comment: "navTitle"))
        }
        
    }
    
    private func adddebt() {
        
        if addDebtVM.checkFirstName() {
            return
        }
        if addDebtVM.checkDebtAmount() {
            return
        }
  
 
        if let debtor = addDebtVM.selectedDebtor {
            addDebtVM.updateDebtor(debtor: debtor)
            _ = addDebtVM.createDebt(debtor: debtor, currencyCode: currencyListVM.selectedCurrency.currencyCode)
        } else {
            let debtor = addDebtVM.createDebtor()
            _ = addDebtVM.createDebt(debtor: debtor, currencyCode: currencyListVM.selectedCurrency.currencyCode)
        }

        CDStack.shared.saveContext(context: viewContext)
        
        debtorsDebt.refreshData()
        addDebtVM.resetData()
        currencyListVM.selectedCurrency = Currency.CurrentLocal.localCurrency
        presentationMode.wrappedValue.dismiss()
        
    }
}

//struct AddDebtView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddDebtView()
//            .environmentObject(AddDebtViewModel())
//            .environmentObject(CurrencyListViewModel())
//    }
//}
