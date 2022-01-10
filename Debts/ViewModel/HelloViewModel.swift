//
//  HelloViewModel.swift
//  Debts
//
//  Created by Sergei Volkov on 05.01.2022.
//

import SwiftUI

class HelloViewModel: ObservableObject {

    @Published var oldDebts = [Debt]()
    @Published var newDebts = [DebtMigrationModel]()
    @Published var oldHistoryDebts = [Debt]()
    @Published var newHistoryDebts = [DebtMigrationModel]()
    
    @Published var hello: [HelloModel]

    init(colorScheme: ColorScheme) {

        self.hello =
        [
           HelloModel(id: 0,
                      title: LocalStrings.Views.HelloView.title0,
                      text: LocalStrings.Views.HelloView.text0,
                      image: "AppStoreIcon" + ImageSchemeHelper.selectSuffixForScheme(colorScheme: colorScheme)),
           HelloModel(id: 1,
                      title: LocalStrings.Views.HelloView.title1,
                      text: LocalStrings.Views.HelloView.text1,
                      image: "hello1" + ImageSchemeHelper.selectSuffixForLocale(colorScheme: colorScheme)),
           HelloModel(id: 2,
                      title: LocalStrings.Views.HelloView.title2,
                      text: LocalStrings.Views.HelloView.text2,
                      image: "hello2" + ImageSchemeHelper.selectSuffixForLocale(colorScheme: colorScheme)),
           HelloModel(id: 3,
                      title: LocalStrings.Views.HelloView.title3,
                      text: LocalStrings.Views.HelloView.text3,
                      image: "hello3" + ImageSchemeHelper.selectSuffixForLocale(colorScheme: colorScheme)),
           HelloModel(id: 4,
                      title: LocalStrings.Views.HelloView.title4,
                      text: LocalStrings.Views.HelloView.text4,
                      image: "hello4" + ImageSchemeHelper.selectSuffixForLocale(colorScheme: colorScheme)),
           HelloModel(id: 5,
                      title: LocalStrings.Views.HelloView.title5,
                      text: LocalStrings.Views.HelloView.text5,
                      image: "hello5" + ImageSchemeHelper.selectSuffixForLocale(colorScheme: colorScheme)),
           HelloModel(id: 6,
                      title: LocalStrings.Views.HelloView.title6,
                      text: LocalStrings.Views.HelloView.text6,
                      systemImage: "gearshape.2.fill"),
       ]
        
    }
    
    
}
