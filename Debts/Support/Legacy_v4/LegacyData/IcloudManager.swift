//
//  IcloudManager.swift
//  Debts
//
//  Created by Sergey Volkov on 08/01/2019.
//  Copyright © 2019 Sergey Volkov. All rights reserved.
//

import Foundation
import UIKit

struct ICloudManager {
    private init() {}
    static var containerUrl: URL? {
        return FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent(ICloudFolder.mainFolder.rawValue)
    }
    
    static func urlFileToCopy(fileName: String) -> URL? {
        if containerUrl != nil {
            print("create containerUrl for '\(fileName)' succerfull - access Icloud granted")
        }
        return self.containerUrl?.appendingPathComponent(fileName).appendingPathExtension("plist")
    }
    
    static func createDirectoryInICloud()-> Bool {
        var flag = true
        if let url = self.containerUrl, !FileManager.default.fileExists(atPath: url.path, isDirectory: nil) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            }
            catch {
                print("error create directory in container - " + error.localizedDescription)
                flag = false
                return flag
            }
        }
        return flag
    }
    
    static func copyFileToICloud(localPath: String, fileName: String)->Bool {
        var flag = true
        guard self.createDirectoryInICloud() else {flag = false; return flag}
        guard let urlFileName = self.urlFileToCopy(fileName: fileName) else {flag = false; return flag}
        
        if FileManager.default.fileExists(atPath: localPath) {
           removeOldFile(path: urlFileName.path)
        }
        
        do {
            try FileManager.default.copyItem(atPath: localPath, toPath: urlFileName.path)
        } catch {
            print("error copy file '\(fileName)' to icloud - " + error.localizedDescription)
            flag = false
        }
        return flag
    }
    
    static func loadFormIcloud(localPath: String, fileName: String)-> Bool {
        var flag = true
        guard self.createDirectoryInICloud() else {flag = false; return flag}
        guard let urlFileName = self.urlFileToCopy(fileName: fileName) else {flag = false; return flag}
        
        if let downFileName = self.containerUrl?.appendingPathComponent(fileName).appendingPathExtension("plist") {
            do {
                try FileManager.default.startDownloadingUbiquitousItem(at: downFileName)
            } catch {
                print("error download file '\(fileName)' from icloud - " + error.localizedDescription)
                flag = false
            }
        }
        
        if FileManager.default.fileExists(atPath: urlFileName.path) {
            removeOldFile(path: localPath)
        }
        
        do {
            try FileManager.default.copyItem(atPath: urlFileName.path, toPath: localPath)
        } catch {
            print("error load file '\(fileName)' from icloud - " + error.localizedDescription)
            flag = false
        }
        return flag
    }
    
    static func downloadFilefromIcloud(fileName: String, completion: @escaping (Bool, String)->Void) {
        
        if let downFileNameData = ICloudManager.containerUrl?.appendingPathComponent(fileName).appendingPathExtension("plist") {
            do {
                try FileManager.default.startDownloadingUbiquitousItem(at: downFileNameData)
            } catch {
                print("Error download \(fileName) file from iCloud: " + error.localizedDescription)
                completion(false, String(localized: "Error download \(fileName) file from iCloud: ") + error.localizedDescription)
                return
            }
        } else {
            print("error - no create fileName")
            completion(false, String(localized: "No access to icloud for the \(fileName) file."))
            return
        }
        completion(true, String(localized: "\(fileName) file download complete."))
    }
    
    static func dowloadFilesFromIcloudToLocalDevice(filesNames: [String], completion: @escaping (Bool, [String])->Void) {
        
        var downloadSeccess = false
        var downloadError = [""]
        
        for fileName in filesNames {
            ICloudManager.downloadFilefromIcloud(fileName: fileName) { (tryDownload, errorString) in
                downloadSeccess = tryDownload
                if errorString != "" {
                    downloadError.append(errorString)
                }
            }
        }
        completion(downloadSeccess, downloadError)
    }

    static func checkFileExistsInContainer()->(access: Bool, fileExists: Bool) {
        
        if self.containerUrl != nil {
            print("containerUrl != nil")
            if let fileList = try? FileManager().contentsOfDirectory(at: self.containerUrl!, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) {
                
                var x = 0
                for (index, _) in fileList.enumerated() {
                    x = index
                }
                if x == 0 {
                    print(true, false)
                    return (true, false)
                } else {
                    print(true, true)
                    return (true, true)
                }
            }
        return (true, false)
        }
        return (false, false)
    }
    
    static func infoAlert(title: String, text: String, buttonText: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let alertOkAction = UIAlertAction(title: buttonText, style: .cancel, handler: nil)
        alert.addAction(alertOkAction)
        return alert
    }
    
    
    
    
}

func removeOldFile (path: String) {
    var isDir:ObjCBool = false
    if FileManager.default.fileExists(atPath: path, isDirectory: &isDir) {
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch {
            print("error remove file \(path) - \(error.localizedDescription)")
        }
    }
}


enum ICloudFolder: String {
    case mainFolder = "DebtBackup"
    case testFolder = "Documents"
    enum ICLoudfileName: String {
        case data = "data"
        case blacklist = "blacklist"
        case favCurrency = "favCurrency"
        case history = "history"
    }
    static var allFileNames: [String] {
        return [ICloudFolder.ICLoudfileName.data.rawValue,
                ICloudFolder.ICLoudfileName.blacklist.rawValue,
                ICloudFolder.ICLoudfileName.favCurrency.rawValue,
                ICloudFolder.ICLoudfileName.history.rawValue
        ]
    }
}
enum KeyforUD: String {
    enum Firstdownload: String {
        case firstDownloadData = "firstDownloadData"
        case firstDownloadBlacklist = "firstDownloadBlacklist"
        case firstDownloadFavCurrency = "firstDownloadFavCurrency"
        case firstDownloadhistory = "firstDownloadhistory"
    }
    case one = "1"
}
