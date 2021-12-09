//
//  HistoryCellView.swift
//  Debts
//
//  Created by Sergei Volkov on 05.12.2021.
//

import SwiftUI

struct HistoryCellView: View {
    
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    @ObservedObject var debt: DebtCD
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading, spacing: 4) {
                
                HStack {
                    Text(NSLocalizedString("Closed", comment: " "))
                        .fontWeight(.thin)
                    Spacer()
                    Text(debt.closeDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
                        .fontWeight(.bold)
                }
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(debt.endDate?.daysBetweenDate(toDate: debt.closeDate ?? Date()) ?? -1 > 0 ? .red : .clear)
                )
                
                HStack {
                    Text(debt.localizeDebtStatus)
                        .fontWeight(.thin)
                    Spacer()
                    Text(debt.debtor?.fullName ?? "")
                        .fontWeight(.bold)
                    PersonImage(size: 20, image: debt.debtor?.image as Data?)
                }
                
                
                HStack {
                    Text("Initial debt")
                        .fontWeight(.thin)
                    Spacer()
                    Text(debt.debtPrefix + currencyVM.currencyConvert(amount: debt.initialDebt as Decimal, currencyCode: debt.currencyCode))
                        .foregroundColor(DebtorStatus(rawValue: debt.debtorStatus) == DebtorStatus.debtor ? Color.green : Color.red)
                        .fontWeight(.bold)

                }
                
                if debt.debtBalance != 0 {
                    HStack {
                        Text("Balance")
                            .fontWeight(.thin)
                        Spacer()
                        Text((debt.debtorStatus == "debtor" ? debt.debtPrefix : "") + currencyVM.debtBalanceFormat(debt: debt))
                            .foregroundColor(DebtorStatus(rawValue: debt.debtorStatus) == DebtorStatus.debtor ? Color.green : Color.red)
                            .fontWeight(.bold)
                    }
                }
                
                if DebtorStatus(rawValue: debt.debtorStatus) == DebtorStatus.debtor {
                    HStack {
                        Text("Profit")
                            .fontWeight(.thin)
                        Spacer()
                        Text((debt.profitBalance > 0 ? debt.debtPrefix : "") + currencyVM.currencyConvert(amount: debt.profitBalance, currencyCode: debt.currencyCode))
                            .foregroundColor(debt.profitBalance > 0 ? Color.green : Color.secondary)
                            .fontWeight(.bold)
                    }
                }

            }
            
        }
        
        .modifier(CellModifire(frameMinHeight: 40, useShadow: true))
    }
}