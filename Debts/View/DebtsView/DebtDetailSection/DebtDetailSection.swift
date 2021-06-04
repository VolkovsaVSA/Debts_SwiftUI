//
//  DebtDatailSection.swift
//  Debts
//
//  Created by Sergei Volkov on 07.05.2021.
//

import SwiftUI

struct DebtDetailSection: View {
    
    @EnvironmentObject var currencyVM: CurrencyViewModel
    @ObservedObject var debt: DebtCD
    
    var body: some View {
        
        Section(header: Text("Debt")) {
            VStack(alignment: .center, spacing: 8) {
                DebtDetailHStackCell(firstColumn: DebtorStatus.statusCDLocalize(status: debt.debtorStatus),
                                     secondColumn: debt.debtor?.fullName ?? NSLocalizedString("no debtor", comment: ""))
                DebtDetailHStackCell(firstColumn: NSLocalizedString("Initial debt", comment: ""),
                                     secondColumn: currencyVM.currencyConvert(amount: debt.initialDebt as Decimal, currencyCode: debt.currencyCode))
                DebtDetailHStackCell(firstColumn: NSLocalizedString("Balance", comment: ""),
                                     secondColumn: currencyVM.currencyConvert(amount: debt.fullBalance as Decimal, currencyCode: debt.currencyCode))
                DebtDetailHStackCell(firstColumn: NSLocalizedString("Start date", comment: ""),
                                     secondColumn: debt.localizeStartDateAndTime)
                DebtDetailHStackCell(firstColumn: NSLocalizedString("End date", comment: ""),
                                     secondColumn: debt.localizeEndDateAndTime)

                if debt.percent != 0 {
//                    DebtDetailHStackCell(firstColumn: NSLocalizedString("Interest", comment: ""),
//                                         secondColumn: debt.percent.description + "% " + PercentType.percentTypeConvert(type: PercentType(rawValue: Int(debt.percentType)) ?? .perYear))
//                    
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(NSLocalizedString("Interest", comment: ""))
                                .font(.system(size: 17, weight: .thin, design: .default))
                            Text("(" + debt.convertedPercentBalanceType + ")")
                                .font(.system(size: 12, weight: .thin, design: .default))
                        }
                        
                        Spacer()
                        
                        
                        Text(debt.percent.description + "% " + PercentType.percentTypeConvert(type: PercentType(rawValue: Int(debt.percentType)) ?? .perYear))
                            .font(.system(size: 17, weight: .medium, design: .default))
                    }
                    
                    
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(NSLocalizedString("Interest charges", comment: ""))
                                .font(.system(size: 17, weight: .thin, design: .default))
                            Text("at " + MyDateFormatter.convertDate(date: Date(), dateStyle: .short, timeStyle: .short))
                                .font(.system(size: 12, weight: .thin, design: .default))
                        }
                        
                        Spacer()
                        
                        
                        Text(CurrencyViewModel.shared.currencyConvert(amount: debt.calculatePercentAmountFunc(balanceType: Int(debt.percentBalanceType)) as Decimal, currencyCode: debt.currencyCode))
                            .font(.system(size: 17, weight: .medium, design: .default))
                    }
                    
                    
//                    DebtDetailHStackCell(firstColumn: NSLocalizedString("Interest charges", comment: ""),
//                                         secondColumn: CurrencyViewModel.shared.currencyConvert(amount: debt.calculatePercentAmountFunc(balanceType: Int(debt.percentBalanceType)) as Decimal, currencyCode: debt.currencyCode))
                }
            }
        }
    }
    
}
