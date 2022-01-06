//
//  DownloadModeView.swift
//  Debts
//
//  Created by Sergei Volkov on 06.01.2022.
//

import SwiftUI

struct DownloadModeView: View {

    @EnvironmentObject private var settingsVM: SettingsViewModel
//    @State private var isError = false
    @State private var isDownload = false
    @State private var downloadErrors = [String]()
    
    var body: some View {
        LoadingView(isShowing: $isDownload, text: NSLocalizedString("Loding", comment: " ")) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Here you can download a backup copy of old data from iCloud, if you had one.")
                        .font(.system(size: 18, weight: .heavy, design: .default))
                    Text("Attention!")
                        .font(.system(size: 22, weight: .heavy, design: .default))
                    Text("The current old data on this device will be permanent destroyed! Do this only if you really need to replace the current old data with a backup copy. Or if you do not have data on this device and you want to transfer old data to this device.")
                    Text("After successful download, run the data conversion again from the menu **\"settings / what's new\"**")

                    HStack {
                        Spacer()
                        Button("Download") {
                            isDownload = true
                            let group = DispatchGroup()
                            group.enter()
                            ICloudManager.dowloadFilesFromIcloudToLocalDevice(filesNames: ICloudFolder.allFileNames) { (complete, error) in
                                if !complete {
                                    downloadErrors = error
                                    isDownload = false
                                    return
                                }
                            }
                            
                            group.leave()
                            
                            if ICloudManager.checkFileExistsInContainer().access {
                                if ICloudManager.checkFileExistsInContainer().fileExists {
                                    group.enter()
                                    let loadData = ICloudManager.loadFormIcloud(localPath: PathForSave.debtData, fileName: ICloudFolder.ICLoudfileName.data.rawValue)
                                    let _ = ICloudManager.loadFormIcloud(localPath: PathForSave.history, fileName: ICloudFolder.ICLoudfileName.history.rawValue)
                                    group.leave()
                                    
                                    group.notify(queue: .main) {
                                        if loadData {
                                            downloadErrors.append(NSLocalizedString("Backup download successfully.", comment: ""))
                                            isDownload = false
                                            return
                                        } else {
                                            downloadErrors.append(NSLocalizedString("Something is wrong. Try again.", comment: ""))
                                            isDownload = false
                                            return
                                        }
                                    }
                                } else {
                                    downloadErrors.append(NSLocalizedString("You have no backup!", comment: ""))
                                    isDownload = false
                                }
                            } else {
                                downloadErrors.append(NSLocalizedString("No access to icloud. Check your internet connection and log in to icloud.", comment: ""))
                                isDownload = false
                            }
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        Spacer()
                    }
                    .padding(20)
                    
                    if !downloadErrors.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(downloadErrors, id: \.self) { error in
                                Text(error)
                                    .lineLimit(nil)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                    
    //                Spacer()
                    
                }
            }
            
            .padding()
        }
        
        
    }
}

