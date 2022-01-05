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
            Section(header: Text("Test")) {
//                Button("Download files from icloud documents") {
//                    Task {
//                        ICloudManager.dowloadFilesFromIcloudToLocalDevice(filesNames: ICloudFolder.allFileNames) { (complete, error) in
//                            if complete {
//                                donloadStatus = "Success!"
//                            } else {
//                                donloadStatus = error.description
//                            }
//                        }
//                    }
//                }
//                ForEach(donloadStatus.components(separatedBy: [",", "[", "]"]), id:\.self) { str in
//                    if str != "" && str != "\"\"" {
//                        Text(str)
//                    }
//                }
                
                Button("Read old data") {
                    oldDebts = migrationMan.LoadOldData()
                    newDebts = migrationMan.convertDebtModel(debts: oldDebts)
                    oldHistoryDebts = migrationMan.LoadOldHistory()
                    newHistoryDebts = migrationMan.convertDebtModel(debts: oldHistoryDebts)
                }
                
                ForEach(newHistoryDebts, id:\.self) { debt in
                    VStack {
                        Text(debt.name)
                        Text(debt.name.components(separatedBy: " ").first ?? NSLocalizedString("Debtors first name", comment: "migration"))
                        Text(debt.name.components(separatedBy: " ").count > 2 ? debt.name.components(separatedBy: " ")[1] : "Family name")
                        Text(debt.summ.description)
                        HStack {
                            Text(debt.startDate.formatted(date: .abbreviated, time: .omitted))
                            Text("-")
                            Text(debt.date.formatted(date: .abbreviated, time: .omitted))
                        }
                        Text(OldMyDateFormatter.fullDateAndTime().date(from: debt.item2)?.description(with: .current) ?? "not convert")
                        Text(debt.endPayDate.description)
//                        Text(OldMyDateFormatter.fullDateAndTime().da)
                    }
                    
                }
                
                Button("Migrate") {
                    migrationMan.migrateDebts(debts: newDebts, debtsIsClosed: false)
                    migrationMan.migrateDebts(debts: newHistoryDebts, debtsIsClosed: true)
                }
                
            }
        }
        .navigationTitle("Test migration data")
    }
}
