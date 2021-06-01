//
//  DebtsCellView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct DebtsCellView: View {
    
    @EnvironmentObject var currencyVM: CurrencyViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    
    @State var debt: DebtCD
    
    var body: some View {
        
        HStack {
            
            PersonImage()

            VStack(alignment: .leading, spacing: 2) {
                Text(debt.debtor?.fullName ?? "N/A")
                    .lineLimit(2)
                    .font(.system(size: 20, weight: .medium, design: .default))

                Text(currencyVM.currencyFormat(debt: debt))
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(DebtorStatus(rawValue: debt.debtorStatus) == DebtorStatus.debtor ? Color.green: Color.red)

                HStack(spacing: 2) {
                    Text(debt.localizeStartDateShort).fontWeight(.light)
                    Text("-").fontWeight(.light)
                    Text(debt.localizeEndDateShort).fontWeight(.light)
                }
                
                .padding(2)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(.clear)
                )
                .font(.caption)
            }
            Spacer()

            if settingsVM.showAdditionalInfo {
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Initial debt")
                    Text(currencyVM.currencyConvert(amount: debt.initialDebt as Decimal, currencyCode: debt.currencyCode))
                    Divider()
                    if let interest = debt.percent,
                       let type = debt.percentType {
                        if interest as Decimal > 0 {
                            HStack(spacing: 2) {
                                Text(interest.description)
                                Text("%")
                                Text(PercentType.percentTypeConvert(type: PercentType(rawValue: Int(type)) ?? .perYear))
                            }
                            VStack(alignment: .trailing, spacing: 2) {
                                Text(currencyVM.currencyConvert(amount: debt.calculatePercentAmountFunc(balanceType: Int(debt.percentBalanceType)) as Decimal,
                                                                currencyCode: debt.currencyCode))
                                HStack(spacing: 2) {
                                    Text("to")
                                    Text(MyDateFormatter.convertDate(date: Date(), dateStyle: .short, timeStyle: .none))
                                }
                            }
                            
                            
                        }
                        
                    }
                    Spacer()
                }
                .font(.system(size: 12, weight: .thin, design: .default))
                .frame(width: 86)
            }
            
            
        }
        .modifier(CellModifire())
    }
}

//struct DebtsCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        DebtsCellView(item: Debt(initialDebt: 100,
//                                 balanceOfDebt: 100,
//                                 isClosed: false,
//                                 payments: [],
//                                 debtor: Debtor(fristName: "Ivan",
//                                                familyName: "Ivanov",
//                                                phone: nil,
//                                                email: nil,
//                                                debts: []),
//                                 currencyCode: "USD",
//                                 debtorStatus: DebtorStatus.debtor))
//    }
//}
