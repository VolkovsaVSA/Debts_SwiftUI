//
//  HistoryViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 05.11.2021.
//

import SwiftUI

final class HistoryViewModel: ObservableObject {
    static let shared = HistoryViewModel()
    
    @Published var refreshedID = UUID()
    @Published var loading = false
    var shareData = ""
    
    func prepareHistoryOneDebt(debt: DebtCD) -> String {
        var result = ""
        result.append(LocalStrings.Debt.Attributes.startDate + ": ")
        result.append(debt.startDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
        result.append("\n")
        result.append(LocalStrings.Debt.Attributes.endDate + ": ")
        result.append(debt.endDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
        result.append("\n")
        
        if let closeDate = debt.closeDate {
            result.append(LocalStrings.Views.History.closed + ": ")
            result.append(closeDate.formatted(date: .abbreviated, time: .shortened))
            result.append("\n")
        }

        result.append(DebtorStatus.statusCDLocalize(status: debt.debtorStatus) + ": " + debt.debtor!.fullName)
        result.append("\n")
        
        if let phone = debt.debtor?.phone {
            result.append(LocalStrings.Debtor.Attributes.phone + ": ")
            result.append(phone)
            result.append("\n")
        }
        if let email = debt.debtor?.email {
            result.append(LocalStrings.Debtor.Attributes.email + ": ")
            result.append(email)
            result.append("\n")
        }
        
        result.append(LocalStrings.Views.DebtsView.initialDebt + ": " + Currency.currencyFormatter(currency: debt.initialDebt as Decimal, currencyCode: debt.currencyCode, showCode: CurrencyViewModel.shared.showCurrencyCode))
        result.append("\n")
        result.append(LocalStrings.Views.DebtsView.balance + ": " + Currency.currencyFormatter(currency: debt.debtBalance, currencyCode: debt.currencyCode, showCode: CurrencyViewModel.shared.showCurrencyCode))
        result.append("\n")
        
        
        if debt.percent != 0 {
            result.append(LocalStrings.Debt.Attributes.interest + " (" + debt.convertedPercentBalanceType + "): ")
            result.append(debt.percent.description + "% " + PercentType.percentTypeConvert(type: PercentType(rawValue: Int(debt.percentType)) ?? .perYear))
            result.append("\n")
            result.append(LocalStrings.Views.DebtsView.interestCharges + " " + LocalStrings.Views.DebtsView.at + (debt.closeDate ?? Date()).formatted(date: .abbreviated, time: .shortened) + ": ")
            result.append(CurrencyViewModel.shared.currencyConvert(amount: debt.calculatePercentAmountFunc(balanceType: Int(debt.percentBalanceType), calcPercent: debt.percent as Decimal, calcPercentType: Int(debt.percentType), defaultLastDate: (debt.closeDate ?? Date())), currencyCode: debt.currencyCode))
            result.append("\n")
            result.append(LocalStrings.Views.DebtsView.interestBalance + " " + LocalStrings.Views.DebtsView.at + (debt.closeDate ?? Date()).formatted(date: .abbreviated, time: .shortened) + ": ")
            result.append(CurrencyViewModel.shared.currencyConvert(amount: debt.interestBalance(defaultLastDate: (debt.closeDate ?? Date())), currencyCode: debt.currencyCode))
            result.append("\n")
        }
        if (debt.penaltyFixedAmount != nil) || (debt.penaltyDynamicType != nil) {
            
            if let wrapFixedSum = debt.penaltyFixedAmount {
                result.append(LocalStrings.Views.DebtsView.penalty + ": ")
                result.append(CurrencyViewModel.shared.currencyConvert(amount: wrapFixedSum as Decimal, currencyCode: debt.currencyCode))
                result.append("\n")
            }

            if let wrapPenaltyDynamicType = debt.penaltyDynamicType,
               let wrapPenaltyDynamicPeriod = debt.penaltyDynamicPeriod,
               let wrapPenaltyDynamicValue = debt.penaltyDynamicValue
            {
                
                result.append(LocalStrings.Views.DebtsView.penalty + ": ")
                result.append(wrapPenaltyDynamicType == "amount"
                              ? CurrencyViewModel.shared.currencyConvert(amount: wrapPenaltyDynamicValue as Decimal, currencyCode: debt.currencyCode) + " " + PenaltyType.DynamicType.DynamicPeriod.dynamicPeriodCDLocalize(period: wrapPenaltyDynamicPeriod)
                              : wrapPenaltyDynamicValue.description + "% " + PenaltyType.DynamicType.DynamicPeriod.dynamicPeriodCDLocalize(period: wrapPenaltyDynamicPeriod))
                result.append("\n")
            }


            if let wrapPenaltyDynamicPercentChargeType = debt.penaltyDynamicPercentChargeType {
                result.append(LocalStrings.Views.DebtsView.penaltyChargeType + ": ")
                result.append(wrapPenaltyDynamicPercentChargeType == PenaltyType.DynamicType.PercentChargeType.initialDebt.rawValue ? PenaltyType.DynamicType.PercentChargeType.initialDebtLocalString : PenaltyType.DynamicType.PercentChargeType.balanceLocalString)
                result.append("\n")
            }
            
            result.append(LocalStrings.Views.DebtsView.penaltyCharges + ": ")
            result.append(CurrencyViewModel.shared.currencyConvert(amount: debt.calcPenalties(toDate: (debt.closeDate ?? Date())),
                                                                   currencyCode: debt.currencyCode))
            result.append("\n")
            result.append(LocalStrings.Views.DebtsView.penaltyBalance + ": ")
            result.append(CurrencyViewModel.shared.currencyConvert(amount: debt.penaltyBalance(toDate: (debt.closeDate ?? Date())), currencyCode: debt.currencyCode))
            result.append("\n")
        }
        if debt.closeDate != nil {
            result.append(LocalStrings.Views.History.profit + ": " + Currency.currencyFormatter(currency: debt.profitBalance, currencyCode: debt.currencyCode, showCode: CurrencyViewModel.shared.showCurrencyCode))
        }
    
        result.append("\n\n")
        
        if !debt.allPayments.isEmpty {
            result.append(String(localized: "Payments (\(debt.allPayments.count))"))
            result.append("\n")
            debt.allPayments.forEach { payment in
                result.append("--------------------------------")
                result.append("\n")
                result.append(payment.date!.formatted(date: .abbreviated, time: .shortened))
                result.append("\n")
                result.append(LocalStrings.Views.PaymentView.debtPart
                                 + Currency.currencyFormatter(currency: payment.paymentDebt as Decimal, currencyCode: debt.currencyCode, showCode: CurrencyViewModel.shared.showCurrencyCode)
                                 +  " / "
                                 + LocalStrings.Views.PaymentView.interestPart
                                 + Currency.currencyFormatter(currency: payment.paymentPercent as Decimal, currencyCode: debt.currencyCode, showCode: CurrencyViewModel.shared.showCurrencyCode)
                )
                result.append("\n")
                
            }
        }
        result.append("\n\n\n")
        return result
    }
    
    func prepareHistorytoExport(inputDebts: FetchedResults<DebtCD>) -> String {
        var result = Date().formatted(date: .abbreviated, time: .complete)
        result.append("\n")
        result.append(String(localized: "History debts of "))
        result.append(AppId.displayName ?? "")
        result.append("\n")
        result.append(AppId.appUrl?.absoluteString ?? "")
        result.append("\n\n")
        
        var index = 1
        
        inputDebts.forEach { localDebt in
            result.append(index.description + ".")
            result.append("\n")
            result.append(prepareHistoryOneDebt(debt: localDebt))
            index += 1
        }

        return result
    }
}
