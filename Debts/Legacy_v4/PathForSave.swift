//
//  PathForSave.swift
//  Debts
//
//  Created by Sergey Volkov on 29.09.2020.
//  Copyright © 2020 Sergey Volkov. All rights reserved.
//

import Foundation


struct PathForSave {
    private static let pathForSaveLibrary = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    static let debtData = pathForSaveLibrary + "/data.plist"
    static let blackList = pathForSaveLibrary + "/blacklist.plist"
    static let favCurrency = pathForSaveLibrary + "/favCurrency.plist"
    static let history = pathForSaveLibrary + "/history.plist"
}
