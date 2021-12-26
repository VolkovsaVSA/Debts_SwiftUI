//
//  TestMigrationDataView.swift
//  Debts
//
//  Created by Sergei Volkov on 27.12.2021.
//

import SwiftUI

struct TestMigrationDataView: View {
    
    @State private var donloadStatus = "n/a"
    
    var body: some View {
        Form {
            Section(header: Text("Test")) {
                Button("Download files from icloud documents") {
                    Task {
                        ICloudManager.dowloadFilesFromIcloudToLocalDevice(filesNames: ICloudFolder.allFileNames) { (complete, error) in
                            if complete {
                                donloadStatus = "Success!"
                            } else {
                                donloadStatus = error.description
                            }
                        }
                    }
                }
                ForEach(donloadStatus.components(separatedBy: [",", "[", "]"]), id:\.self) { str in
                    if str != "" && str != "\"\"" {
                        Text(str)
                    }
                }
                
                Button("Migrate data") {
                    
                }
            }
        }
        .navigationTitle("Test migration data")
    }
}
