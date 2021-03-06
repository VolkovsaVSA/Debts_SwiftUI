//
//  AppID.swift
//  Neslis
//
//  Created by Sergey Volkov on 27.12.2020.
//

import Foundation

struct AppId {
    private init() {}
    
    private static let appID = "1385708953"
//    static let appHttp = "http://itunes.apple.com/app/id" + AppId.appID
    static let appUrl = URL(string: "itms-apps://itunes.apple.com/app/id" + AppId.appID)
    static let feedbackEmail = "indebt@vsa.su"
    static let developerUrl = URL(string: "https://apps.apple.com/developer/sergei-volkov/id1385708952")
    static let displayName = Bundle.main.infoDictionary?.filter({ $0.key == "CFBundleDisplayName" }).first?.value as? String
    
}
