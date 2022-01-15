//
//  DebtsWidget.swift
//  DebtsWidget
//
//  Created by Sergei Volkov on 13.01.2022.
//

import WidgetKit
import SwiftUI
import Intents
import CoreData

struct Provider: IntentTimelineProvider {
 
    func placeholder(in context: Context) -> DebtsEntry {
        DebtsEntry()
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (DebtsEntry) -> ()) {
        let entry = DebtsEntry()
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeLine = Timeline(entries: [DebtsEntry()], policy: .atEnd)
        completion(timeLine)
    }
}

struct DebtsEntry: TimelineEntry {
    let date: Date  = Date()
    var debts: Array<DebtCD>
    
    init() {
        var tempdebts = CDStack.shared.fetchDebts(isClosed: false)
        
        let sortType = DebtSortType(rawValue: AppGroup.MyDefaults.load(key: UDKeys.sortType) as! Int)
        let sortDecrease = AppGroup.MyDefaults.load(key: UDKeys.sortDecrease) as! Bool
        
        switch sortType {
            case .name:
                sortDecrease ?
                tempdebts.sort {($0.debtor?.fullName ?? "") > ($1.debtor?.fullName ?? "")} :
                tempdebts.sort {($0.debtor?.fullName ?? "") < ($1.debtor?.fullName ?? "")}
            case .debt:
                sortDecrease ?
                tempdebts.sort {($0.debtBalance + $0.interestBalance(defaultLastDate: Date())) > ($1.debtBalance + $1.interestBalance(defaultLastDate: Date()))} :
                tempdebts.sort {($0.debtBalance + $0.interestBalance(defaultLastDate: Date())) < ($1.debtBalance + $1.interestBalance(defaultLastDate: Date()))}
            case .startDate:
                sortDecrease ?
                tempdebts.sort {($0.startDate ?? Date()) > ($1.startDate ?? Date())} :
                tempdebts.sort {($0.startDate ?? Date()) < ($1.startDate ?? Date())}
            case .endDate:
                sortDecrease ?
                tempdebts.sort {($0.endDate ?? Date()) > ($1.endDate ?? Date())} :
                tempdebts.sort {($0.endDate ?? Date()) < ($1.endDate ?? Date())}
            case .none:
                tempdebts.sort {($0.endDate ?? Date()) < ($1.endDate ?? Date())}
        }
        
        debts = tempdebts
    }
}

struct DebtsWidgetEntryView : View {
    
    @Environment(\.widgetFamily) private var family

    var entry: Provider.Entry
    private var fontSize: CGFloat {
        return 14
    }


    var body: some View {

        ForEach(entry.debts.prefix(family != .systemLarge ? 2 : 4)) { debt in
            
            HStack {
                if family != .systemSmall {
                    PersonImage(size: 44, image: debt.debtor?.image)
                        .padding(.horizontal, 10)
                } else {
                    Spacer()
                }

                if family != .systemSmall {
                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            Text(debt.debtor?.fullName ?? "n/a")
                            Text(CurrencyViewModel().debtBalanceFormat(debt: debt))
                                .foregroundColor(DebtorStatus(rawValue: debt.debtorStatus) == DebtorStatus.debtor ? Color.green : Color.red)
                        }
                        
                        HStack {
                            Text(debt.startDate?.formatted(date: .abbreviated, time: .omitted) ?? Date().description)
                            Text("-")
                            Text(debt.endDate?.formatted(date: .abbreviated, time: .omitted) ?? Date().description)
                        }
                        .padding(.horizontal, 2)
                        .background((Date() > debt.endDate ?? Date()) ? Color.red: Color.clear)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                    
                } else {
                    VStack(alignment: .center, spacing: 0) {
                        Text(debt.debtor?.fullName ?? "n/a")
                        Text(CurrencyViewModel().debtBalanceFormat(debt: debt))
                            .foregroundColor(DebtorStatus(rawValue: debt.debtorStatus) == DebtorStatus.debtor ? Color.green : Color.red)
                        Text(debt.endDate?.formatted(date: .abbreviated, time: .omitted) ?? Date().description)
                            .padding(.horizontal, 4
                            )
                            .background((Date() > debt.endDate ?? Date()) ? Color.red: Color.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                }
                Spacer()
            }
            .padding(0.5)
            .font(Font.system(size: fontSize, weight: .bold, design: .default))
            .lineLimit(1)
        }
    }
    
}

@main
struct DebtsWidget: Widget {
    let kind: String = "DebtsWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            DebtsWidgetEntryView(entry: entry)
                
        }
//        .configurationDisplayName("\(Bundle.main.displayName) Widget")
//        .description("This is an \(Bundle.main.displayName) widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
