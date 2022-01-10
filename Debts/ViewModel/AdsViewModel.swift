//
//  AdsViewModel.swift
//  Mriffa
//
//  Created by Sergei Volkov on 17.09.2021.
//

import Foundation
import GoogleMobileAds

class AdsViewModel: ObservableObject {
    static let shared = AdsViewModel()
    @Published var interstitial = AdsManager.Interstitial()
    @Published var showInterstitial = false {
        didSet {
            if !UserDefaults.standard.bool(forKey: IAPProducts.fullVersion.rawValue) {
                if showInterstitial {
                    interstitial.showAd()
                    showInterstitial = false
                } else {
                    interstitial.requestInterstitialAds()
                }
            }
            
        }
    }
}
