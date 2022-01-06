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
    
    let isPeymentView: Bool
    let lastDateForAddedPaymentview: Date?
    
    var body: some View {
        
        Section(
            header: Text(debt.debtorStatus == "debtor" ? LocalizedStringKey("Debt") : LocalizedStringKey("Credit")).fontWeight(.bold).foregroundColor(.primary)
        ) {
            VStack(alignment: .center, spacing: 8) {
                DebtDetailHStackCell(firstColumn: DebtorStatus.statusCDLocalize(status: debt.debtorStatus),
                                     secondColumn: debt.debtor?.fullName ?? NSLocalizedString("no debtor", comment: ""))
                DebtDetailHStackCell(firstColumn: NSLocalizedString("Initial debt", comment: ""),
                                     secondColumn: currencyVM.currencyConvert(amount: debt.initialDebt as Decimal, currencyCode: debt.currencyCode))
                DebtDetailHStackCell(firstColumn: NSLocalizedString("Balance", comment: ""),
                                     secondColumn: currencyVM.currencyConvert(amount: debt.debtBalance as Decimal, currencyCode: debt.currencyCode))
                DebtDetailHStackCell(firstColumn: NSLocalizedString("Start date", comment: ""),
                                     secondColumn: debt.localizeStartDateAndTime)
                DebtDetailHStackCell(firstColumn: NSLocalizedString("End date", comment: ""),
                                     secondColumn: debt.localizeEndDateAndTime)
                
                if debt.percent != 0 {
                    if isPeymentView {
                        DebtDetailInterestSection(defaultLastDate: lastDateForAddedPaymentview ?? Date())
                    } else {
                        DebtDetailInterestSection(defaultLastDate: Date())
                    }
                }
            }
            
//            if !isPeymentView {
//                if (debt.penaltyFixedAmount != nil) || (debt.penaltyDynamicType != nil) {
//                    DebtPenaltySection(debt: debt)
////                        .listRowSeparator(.hidden)
//                }
//            }
            
        }
        if !isPeymentView {
            if (debt.penaltyFixedAmount != nil) || (debt.penaltyDynamicType != nil) {
                DebtPenaltySection(debt: debt, toDate: Date())
//                        .listRowSeparator(.hidden)
            }
        }
    }
    
    private func DebtDetailInterestSection(defaultLastDate: Date)  -> some View {
        return Group {
            DebtDetailHStackCell(firstColumn: String(localized: "Interest"),
                                 firstColumnDetail: "(" + debt.convertedPercentBalanceType + ")",
                                 secondColumn: debt.percent.description + "% " + PercentType.percentTypeConvert(type: PercentType(rawValue: Int(debt.percentType)) ?? .perYear))
            DebtDetailHStackCell(firstColumn: String(localized: "Interest charges"),
                                 firstColumnDetail: "at " + DateToStringFormatter.convertDate(date: defaultLastDate, dateStyle: .short, timeStyle: .short),
                                 secondColumn: CurrencyViewModel.shared.currencyConvert(amount: debt.calculatePercentAmountFunc(balanceType: Int(debt.percentBalanceType), calcPercent: debt.percent as Decimal, calcPercentType: Int(debt.percentType), defaultLastDate: defaultLastDate), currencyCode: debt.currencyCode))
            DebtDetailHStackCell(firstColumn: String(localized: "Interest balance"),
                                 firstColumnDetail: "at " + DateToStringFormatter.convertDate(date: defaultLastDate, dateStyle: .short, timeStyle: .short),
                                 secondColumn: CurrencyViewModel.shared.currencyConvert(amount: debt.interestBalance(defaultLastDate: defaultLastDate), currencyCode: debt.currencyCode))
        }
    }
}
