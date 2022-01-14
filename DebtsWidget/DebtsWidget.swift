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
    var debts: ArraySlice<DebtCD>
    
    init() {
        let tempdebts = CDStack.shared.fetchDebts(isClosed: false)
        debts = tempdebts.sorted {$0.endDate! < $1.endDate!}.prefix(2)
    }
}

struct DebtsWidgetEntryView : View {

    var entry: Provider.Entry
    private var fontSize: CGFloat {
        switch entry.debts.count {
            case 1...2: return 14
            default: return 12
        }
    }

    var body: some View {

        ForEach(entry.debts) { debt in
            VStack(alignment: .center, spacing: 0) {
                Text(debt.debtor?.fullName ?? "n/a")
                Text(CurrencyViewModel.shared.debtBalanceFormat(debt: debt))
                    .foregroundColor(DebtorStatus(rawValue: debt.debtorStatus) == DebtorStatus.debtor ? Color.green : Color.red)
                Text(debt.endDate?.formatted(date: .abbreviated, time: .omitted) ?? Date().description)
                    .background((Date() > debt.endDate ?? Date()) ? Color.red: Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
            .font(Font.system(size: fontSize, weight: .bold, design: .default))
            .padding(0.5)
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
        .supportedFamilies([.systemSmall])
    }
}
