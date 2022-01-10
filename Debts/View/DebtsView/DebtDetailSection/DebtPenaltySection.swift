//
//  DebtPenaltySection.swift
//  Debts
//
//  Created by Sergei Volkov on 21.11.2021.
//

import SwiftUI

struct DebtPenaltySection: View {
    
    @EnvironmentObject private var currencyVM: CurrencyViewModel
    @ObservedObject var debt: DebtCD
    @State var toDate: Date
    
    var body: some View {
        Section(header: Text(LocalStrings.Views.DebtsView.penalty).fontWeight(.bold).foregroundColor(.primary)) {
            
            VStack(alignment: .center, spacing: 8) {
                if let wrapFixedSum = debt.penaltyFixedAmount {
                    DebtDetailHStackCell(firstColumn: LocalStrings.Views.DebtsView.fixedSum,
                                         firstColumnDetail: nil,
                                         secondColumn: CurrencyViewModel.shared.currencyConvert(amount: wrapFixedSum as Decimal, currencyCode: debt.currencyCode)
                    )
                }

                if let wrapPenaltyDynamicType = debt.penaltyDynamicType,
                   let wrapPenaltyDynamicPeriod = debt.penaltyDynamicPeriod,
                   let wrapPenaltyDynamicValue = debt.penaltyDynamicValue
                {
                    DebtDetailHStackCell(firstColumn:
                                            PenaltyType.DynamicType.dynamicTypeCDLocalize(type: wrapPenaltyDynamicType),
                                         firstColumnDetail: nil,
                                         secondColumn:
                                            wrapPenaltyDynamicType == "amount"
                                         ? CurrencyViewModel.shared.currencyConvert(amount: wrapPenaltyDynamicValue as Decimal, currencyCode: debt.currencyCode) + " " + PenaltyType.DynamicType.DynamicPeriod.dynamicPeriodCDLocalize(period: wrapPenaltyDynamicPeriod)
                                         : wrapPenaltyDynamicValue.description + "% " + PenaltyType.DynamicType.DynamicPeriod.dynamicPeriodCDLocalize(period: wrapPenaltyDynamicPeriod)

                    )
                }


                if let wrapPenaltyDynamicPercentChargeType = debt.penaltyDynamicPercentChargeType {
                    DebtDetailHStackCell(firstColumn: LocalStrings.Views.DebtsView.penaltyChargeType,
                                         firstColumnDetail: nil,
                                         secondColumn: wrapPenaltyDynamicPercentChargeType)
                }

                DebtDetailHStackCell(firstColumn: LocalStrings.Views.DebtsView.penaltyCharges,
                                     firstColumnDetail: nil,
                                     secondColumn:
                                        CurrencyViewModel
                                        .shared
                                        .currencyConvert(amount: debt.calcPenalties(toDate: toDate),
                                                         currencyCode: debt.currencyCode)
                ).listRowSeparator(.hidden)
                DebtDetailHStackCell(firstColumn: LocalStrings.Views.DebtsView.penaltyBalance,
                                     firstColumnDetail: nil,
                                     secondColumn: CurrencyViewModel.shared.currencyConvert(amount: debt.penaltyBalance(toDate: toDate), currencyCode: debt.currencyCode)
                )
            }
            
        }
    }
}

