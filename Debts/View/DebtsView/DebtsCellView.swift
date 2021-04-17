//
//  DebtsCellView.swift
//  Debts
//
//  Created by Sergei Volkov on 14.04.2021.
//

import SwiftUI

struct DebtsCellView: View {
    
    @State var debt: DebtCD
    
    var body: some View {
        
        HStack {
            
            PersonImage()

            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(debt.debtor?.firstName ?? "")
                    Text(debt.debtor?.familyName ?? "")
                }
                .lineLimit(1)
                .font(.system(size: 20, weight: .medium, design: .default))

                Text(debt.balanceOfDebt.description)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(DebtorStatus(rawValue: debt.debtorStatus) == DebtorStatus.debtor ? Color.green: Color.red)

                HStack(spacing: 2) {
                    if let start = debt.startDate {
                        Text(DateFormatter.localizedString(from: start, dateStyle: .short, timeStyle: .none))
                    }
                    if let end = debt.endDate {
                        Text("-")
                        Text(DateFormatter.localizedString(from: end, dateStyle: .short, timeStyle: .none))
                            .fontWeight(.light)
                    }
                }
                .padding(2)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(.clear)
                )
                .font(.caption)
            }
            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text("Info")
                Text(debt.initialDebt.description)
                if let interest = debt.percent,
                   let type = debt.percentType {
                    HStack(spacing: 2) {
                        Text(interest.description)
                        Text("%")
                        Text(PercentType.percentTypeConvert(type: PercentType(rawValue: Int(type)) ?? .perYear))
                    }
                    Text(debt.percentAmount?.description ?? "")
                }
                Spacer()
            }
            .font(.system(size: 12, weight: .thin, design: .default))
            .padding(4)
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
