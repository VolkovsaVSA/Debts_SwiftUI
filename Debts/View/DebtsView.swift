//
//  DebtsView.swift
//  Debts
//
//  Created by Sergei Volkov on 07.04.2021.
//

import SwiftUI



struct DebtsView: View {
    
    
    
    var body: some View {
        
        ScrollView {
            ForEach(dbt) { item in
                
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 70, height: 70, alignment: .center)
                        .foregroundColor(Color(UIColor.systemGray))
                        .background(Color(UIColor.label))
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            Text(item.debtor.fristName)
                            Text(item.debtor.familyName ?? "")
                        }
                        .lineLimit(1)
                        .font(.system(size: 18, weight: .medium, design: .default))
                        
                        Text(item.balanceOfDebt.description)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(item.debtor.isDebtor ? Color.green: Color.red)
                        
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
                        if let interest = item.interest,
                           let type = item.interestType {
                            HStack(spacing: 2) {
                                Text(interest.description)
                                Text("%")
                                Text(PercentType.percentTypeConvert(type: type))
                            }
                            Text(item.interestAmount?.description ?? "")
                        }
                        Spacer()
                    }
                    .font(.system(size: 12, weight: .thin, design: .default))
                    .padding(4)
                }
                .lineLimit(1)
                .padding(12)
                
//                .background(
//                    LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGray6), Color(UIColor.systemGray4)]),
//                                   startPoint: .top,
//                                   endPoint: .bottom)
//                    )
//                .background(Color(UIColor.systemBlue).opacity(0.2))
                
                .background(item.debtor.isDebtor ? Color.green.opacity(0.2): Color.red.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.bottom, 8)
            }
        }
        
        
    }
    
}

struct DebtsView_Previews: PreviewProvider {
    static var previews: some View {
        DebtsView()
    }
}
