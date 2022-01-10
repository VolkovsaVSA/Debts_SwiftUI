//
//  DownloadModeView.swift
//  Debts
//
//  Created by Sergei Volkov on 06.01.2022.
//

import SwiftUI

struct DownloadModeView: View {

    @EnvironmentObject private var settingsVM: SettingsViewModel
    @State private var isDownload = false
    @State private var downloadErrors = [String]()
    
    var body: some View {
        LoadingView(isShowing: $isDownload, text: LocalStrings.Other.loading) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(LocalStrings.Views.Settings.Download.hereYouCanDownloadABackupCcopy)
                        .font(.system(size: 18, weight: .heavy, design: .default))
                    Text(LocalStrings.Alert.Title.attention)
                        .font(.system(size: 22, weight: .heavy, design: .default))
                    Text(LocalStrings.Views.Settings.Download.currentOldDataOnThisDevice)
                    Text(LocalStrings.Views.Settings.Download.afterSuccessful)

                    HStack {
                        Spacer()
                        Button(LocalStrings.Button.download) {
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
                                            downloadErrors.append(LocalStrings.Views.Settings.Download.backupDownloadSuccessfully)
                                            isDownload = false
                                            return
                                        } else {
                                            downloadErrors.append(LocalStrings.Views.Settings.Download.somethingIsWrong)
                                            isDownload = false
                                            return
                                        }
                                    }
                                } else {
                                    downloadErrors.append(LocalStrings.Views.Settings.Download.youHaveNoBackup)
                                    isDownload = false
                                }
                            } else {
                                downloadErrors.append(LocalStrings.Views.Settings.Download.noAccessToIcloud)
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
                                    .fontWeight(.thin)
                                    .lineLimit(nil)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }

                }
            }
            
            .padding()
        }
        
        
    }
}

