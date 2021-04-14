//
//  DebtsView.swift
//  Debts
//
//  Created by Sergei Volkov on 07.04.2021.
//

import SwiftUI



struct DebtsView: View {
    
    @EnvironmentObject var debtorsDebt: DebtorsDebtsViewModel
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                ForEach(debtorsDebt.debts) { item in
                    
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 70, height: 70, alignment: .center)
                            .foregroundColor(Color(UIColor.systemGray))
                            .background(Color(UIColor.white))
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 2) {
                            HStack {
                                Text(item.debtor.fristName)
                                Text(item.debtor.familyName ?? "")
                            }
                            .lineLimit(1)
                            .font(.system(size: 20, weight: .medium, design: .default))

                            Text(item.balanceOfDebt.description)
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .foregroundColor(item.debtor.debtorStatus == DebtorStatus.debtor ? Color.green: Color.red)

                            HStack(spacing: 2) {
                                if let start = item.startDate {
                                    Text(DateFormatter.localizedString(from: start, dateStyle: .short, timeStyle: .none))
                                }
                                if let end = item.endDate {
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
                            Text(item.initialDebt.description)
                            if let interest = item.percent,
                               let type = item.percentType {
                                HStack(spacing: 2) {
                                    Text(interest.description)
                                    Text("%")
                                    Text(PercentType.percentTypeConvert(type: type))
                                }
                                Text(item.percentAmount?.description ?? "")
                            }
                            Spacer()
                        }
                        .font(.system(size: 12, weight: .thin, design: .default))
                        .padding(4)
                    }
                    .modifier(CellModifire())
                }
                
                .onDelete(perform: onDelete)
            }
            .navigationTitle(LocalizedStringKey("Debts"))
        }
        
        
        
        
    }
    
    private func onDelete(offsets: IndexSet) {
        debtorsDebt.debts.remove(atOffsets: offsets)
    }
    
}

struct DebtsView_Previews: PreviewProvider {
    static var previews: some View {
        DebtsView()
            .environmentObject(DebtorsDebtsViewModel())
    }
}
