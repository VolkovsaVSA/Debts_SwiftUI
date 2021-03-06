//
//  EditedDebtSectionView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.07.2021.
//

import SwiftUI

struct EditedDebtSectionView: View {
    
    @EnvironmentObject private var addDebtVM: AddDebtViewModel
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    
    @State private var refresh = UUID()
    
    @ObservedObject var editedDebt: DebtCD
    
    var body: some View {
        
        Section {
            
            VStack {
                HStack {
                    Text(LocalStrings.Views.AddDebtView.balanceOfDebt)
                        .fontWeight(.thin)
                    Spacer()
                    Text(currencyVM.currencyConvert(amount: editedDebt.debtBalance as Decimal,
                                                    currencyCode: editedDebt.currencyCode))
                        .foregroundColor(.secondary)
                }.id(refresh)
                
                if addDebtVM.isInterest {
                    HStack {
                        Text(LocalStrings.Views.DebtsView.interestBalance)
                            .fontWeight(.thin)
                        Spacer()
                        Text(currencyVM.currencyConvert(amount: editedDebt.interestBalance(defaultLastDate: Date()), currencyCode: editedDebt.currencyCode))
                            .foregroundColor(.secondary)
                    }.id(refresh)
                }

                if editedDebt.checkIsPenalty() {
                    HStack {
                        Text(LocalStrings.Views.DebtsView.penaltyCharges)
                            .fontWeight(.thin)
                        Spacer()
                        Text(currencyVM.currencyConvert(amount: editedDebt.calcPenalties(toDate: Date()) as Decimal,
                                                        currencyCode: editedDebt.currencyCode))
                            .foregroundColor(.secondary)
                    }
                    .id(refresh)
                    
                    if let _ = editedDebt.paidPenalty as Decimal? {
                        HStack {
                            Text(LocalStrings.Views.AddDebtView.penaltyPaid)
                                .fontWeight(.thin)
                            Spacer()
                            TextField("", value: $addDebtVM.paidPenalty, format: .currency(code: editedDebt.currencyCode), prompt: nil)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .frame(width: 200, height: 10, alignment: .trailing)
                        }
                        .id(refresh)
                    }
                }
                
            }
            .padding(.bottom, 4)
  
        }
        
        Section {
            HStack {
                Spacer()
                Button(action: {
                    addDebtVM.addPaymentPush = true
                }, label: {
                    Text(LocalStrings.Views.AddDebtView.addPayment)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(AppSettings.accentColor)
                                .background(
                                    NavigationLink(destination: AddPaymentView(debt: editedDebt, isEditableDebt: true),
                                                   isActive: $addDebtVM.addPaymentPush) {EmptyView()}
                                )
                        )
                })
                .buttonStyle(PlainButtonStyle())
                Spacer()
            }
            .listRowBackground(
                Color.clear
            )
        }


        PaymentsView(debt: editedDebt, isEditable: true)
            .onReceive(editedDebt.objectWillChange) { _ in
                refresh = UUID()
            }
            .listRowBackground(
                Color.clear
            )
    }
}


