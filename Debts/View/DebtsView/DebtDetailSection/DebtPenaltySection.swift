//
//  DebtPenaltySection.swift
//  Debts
//
//  Created by Sergei Volkov on 21.11.2021.
//

import SwiftUI

struct DebtPenaltySection: View {
    
    @EnvironmentObject var currencyVM: CurrencyViewModel
    @ObservedObject var debt: DebtCD
    
    var body: some View {
        Section(header: Text("Penalty").fontWeight(.bold).foregroundColor(.primary)) {
            
            VStack(alignment: .center, spacing: 8) {
                if let wrapFixedSum = debt.penaltyFixedAmount {
                    DebtDetailHStackCell(firstColumn: "Fixed sum",
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
                    DebtDetailHStackCell(firstColumn: "Penalty charge type",
                                         firstColumnDetail: nil,
                                         secondColumn: wrapPenaltyDynamicPercentChargeType)
                }

                DebtDetailHStackCell(firstColumn: "Penalty charges",
                                     firstColumnDetail: nil,
                                     secondColumn: CurrencyViewModel.shared.currencyConvert(amount: debt.calcPenalties(), currencyCode: debt.currencyCode)
                )
                DebtDetailHStackCell(firstColumn: "Penalty balance",
                                     firstColumnDetail: nil,
                                     secondColumn: CurrencyViewModel.shared.currencyConvert(amount: debt.penaltyBalance, currencyCode: debt.currencyCode)
                )
            }
        }
    }
}

