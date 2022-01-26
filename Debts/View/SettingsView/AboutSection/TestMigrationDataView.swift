//
//  TestMigrationDataView.swift
//  Debts
//
//  Created by Sergei Volkov on 27.12.2021.
//

import SwiftUI

struct TestMigrationDataView: View {

    @State private var donloadStatus = "n/a"
    @StateObject private var migrationMan = MigrationManager()
    @State private var oldDebts = [Debt]()
    @State private var newDebts = [DebtMigrationModel]()
    @State private var oldHistoryDebts = [Debt]()
    @State private var newHistoryDebts = [DebtMigrationModel]()


    var body: some View {
        Form {
            Section(header: Text("Тест")) {

                Button("Прочитать старые данные") {
                    oldDebts = migrationMan.LoadOldData()
                    newDebts = migrationMan.convertDebtModel(debts: oldDebts)
                    oldHistoryDebts = migrationMan.LoadOldHistory()
                    newHistoryDebts = migrationMan.convertDebtModel(debts: oldHistoryDebts)
                }

                ForEach(newDebts, id:\.self) { debt in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(debt.name)
                        Text(debt.name.components(separatedBy: " ").first ?? NSLocalizedString("Имя должника", comment: "migration"))
                        Text(debt.name.components(separatedBy: " ").count > 2 ? debt.name.components(separatedBy: " ")[1] : "Фамилия должника")
                        Text(debt.summ.description)
                        Text(debt.localID)
                        HStack {
                            Text(debt.startDate.formatted(date: .abbreviated, time: .omitted))
                            Text("-")
                            Text(debt.date.formatted(date: .abbreviated, time: .omitted))
                        }
                        Text(OldMyDateFormatter.fullDateAndTime().date(from: debt.item2)?.description(with: .current) ?? "дата последнего платежа не конвертировалась")
                        Text(debt.endPayDate.description + " дата закрытия")
//                        Text(OldMyDateFormatter.fullDateAndTime().da)
                    }

                }

                Button("Конвертировать") {
                    migrationMan.migrateDebts(debts: newDebts, debtsIsClosed: false)
                    migrationMan.migrateDebts(debts: newHistoryDebts, debtsIsClosed: true)
                }

            }
        }
        .navigationTitle("Тестирование старых данных")
    }
}
