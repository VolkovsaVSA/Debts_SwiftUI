//
//  DebtDatailSection.swift
//  Debts
//
//  Created by Sergei Volkov on 07.05.2021.
//

import SwiftUI

struct DebtDetailSection: View {
    
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    @ObservedObject var debt: DebtCD
    
    let isPaymentView: Bool
    let lastDateForAddedPaymentview: Date?
    
    var body: some View {
        
        Section(
            header: Text(debt.debtorStatus == DebtorStatus.debtor.rawValue ?
                         LocalStrings.Debt.Attributes.debt :
                        LocalStrings.Views.DebtsView.credit)
                .fontWeight(.bold).foregroundColor(.primary)
        ) {
            VStack(alignment: .center, spacing: 8) {
                DebtDetailHStackCell(firstColumn: DebtorStatus.statusCDLocalize(status: debt.debtorStatus),
                                     secondColumn: debt.debtor?.fullName ?? LocalStrings.Views.DebtsView.noDebtor)
                DebtDetailHStackCell(firstColumn: LocalStrings.Views.DebtsView.initialDebt,
                                     secondColumn: currencyVM.currencyConvert(amount: debt.initialDebt as Decimal, currencyCode: debt.currencyCode))
                DebtDetailHStackCell(firstColumn: LocalStrings.Views.DebtsView.balance,
                                     secondColumn: currencyVM.currencyConvert(amount: debt.debtBalance as Decimal, currencyCode: debt.currencyCode))
                DebtDetailHStackCell(firstColumn: LocalStrings.Debt.Attributes.startDate,
                                     secondColumn: debt.localizeStartDateAndTime)
                DebtDetailHStackCell(firstColumn: LocalStrings.Debt.Attributes.endDate,
                                     secondColumn: debt.localizeEndDateAndTime)
                
                if debt.percent != 0 {
                    if isPaymentView {
                        DebtDetailInterestSection(defaultLastDate: lastDateForAddedPaymentview ?? debt.closeDate ?? Date())
                    } else {
                        DebtDetailInterestSection(defaultLastDate: debt.closeDate ?? Date())
                    }
                }
            }
            
        }
        if !isPaymentView {
            if (debt.penaltyFixedAmount != nil) || (debt.penaltyDynamicType != nil) {
                DebtPenaltySection(debt: debt, toDate: debt.closeDate ?? Date())
            }
        }
    }
    
    private func DebtDetailInterestSection(defaultLastDate: Date)  -> some View {
        return Group {
            DebtDetailHStackCell(firstColumn: LocalStrings.Debt.Attributes.interest,
                                 firstColumnDetail: "(" + debt.convertedPercentBalanceType + ")",
                                 secondColumn: debt.percent.description + "% " + PercentType.percentTypeConvert(type: PercentType(rawValue: Int(debt.percentType)) ?? .perYear))
            DebtDetailHStackCell(firstColumn: LocalStrings.Views.DebtsView.interestCharges,
                                 firstColumnDetail: LocalStrings.Views.DebtsView.at + DateToStringFormatter.convertDate(date: defaultLastDate, dateStyle: .short, timeStyle: .short),
                                 secondColumn: CurrencyViewModel.shared.currencyConvert(amount: debt.calculatePercentAmountFunc(balanceType: Int(debt.percentBalanceType), calcPercent: debt.percent as Decimal, calcPercentType: Int(debt.percentType), defaultLastDate: defaultLastDate), currencyCode: debt.currencyCode))
            DebtDetailHStackCell(firstColumn: LocalStrings.Views.DebtsView.interestBalance,
                                 firstColumnDetail: LocalStrings.Views.DebtsView.at + DateToStringFormatter.convertDate(date: defaultLastDate, dateStyle: .short, timeStyle: .short),
                                 secondColumn: CurrencyViewModel.shared.currencyConvert(amount: debt.interestBalance(defaultLastDate: defaultLastDate), currencyCode: debt.currencyCode))
        }
    }
}
