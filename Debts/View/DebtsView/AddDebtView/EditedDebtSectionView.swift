//
//  EditedDebtSectionView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.07.2021.
//

import SwiftUI

struct EditedDebtSectionView: View {
    
    @EnvironmentObject var addDebtVM: AddDebtViewModel
    @EnvironmentObject var currencyVM: CurrencyViewModel
    
    @State private var refresh = UUID()
    
    @ObservedObject var editedDebt: DebtCD
    
    var body: some View {
        
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
                        Text("Interest balance:")
                            .fontWeight(.thin)
                        Spacer()
                        Text(currencyVM.currencyConvert(amount: editedDebt.interestBalance, currencyCode: editedDebt.currencyCode))
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


