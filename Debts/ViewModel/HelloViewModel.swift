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
        
        print(Locale.current.languageCode)
        
        self.hello =
        [
           HelloModel(id: 0,
                      title: NSLocalizedString("We've updated!", comment: " "),
                      text: NSLocalizedString("We have a lot of interesting and useful things for you in this update. Scroll further to find out what we have prepared for you!", comment: "HelloView"),
                      image: "AppStoreIcon" + ImageSchemeHelper.selectSuffixForScheme(colorScheme: colorScheme)),
           HelloModel(id: 1,
                      title: NSLocalizedString("Now there are payments! Oh really? :)", comment: "HelloView"),
                      text: NSLocalizedString("Each debt now has a payment history. Payments can contain not only a part of the principal, but also a part of accrued interest on the debt.", comment: "HelloView"),
                      image: "payment" + ImageSchemeHelper.selectSuffixForLocale(colorScheme: colorScheme)),
           HelloModel(id: 2,
                      title: NSLocalizedString("Now you can set a late debt penalty!", comment: "HelloView"),
                      text: NSLocalizedString("You can set the fixed amount of the penalty for the debt delay, or the calculation of the penalty for each day or week of the debt delay.", comment: "HelloView"),
                      image: "penalty" + ImageSchemeHelper.selectSuffixForLocale(colorScheme: colorScheme)),
           HelloModel(id: 3,
                      title: NSLocalizedString("Closing debt (part 1)", comment: "HelloView"),
                      text: NSLocalizedString("When the balance of the principal debt, interest and penalties reaches 0, then it will be possible to close the debt.", comment: "HelloView"),
                      image: "close1" + ImageSchemeHelper.selectSuffixForLocale(colorScheme: colorScheme)),
           HelloModel(id: 4,
                      title: NSLocalizedString("Closing debt (part 2)", comment: "HelloView"),
                      text: NSLocalizedString("Now the debt can be closed with a non-zero balance! You can do this from the debt edit screen.", comment: "HelloView"),
                      image: "close2" + ImageSchemeHelper.selectSuffixForLocale(colorScheme: colorScheme)),
           HelloModel(id: 5,
                      title: NSLocalizedString("New history screen!", comment: "HelloView"),
                      text: NSLocalizedString("The debt history screen now displays the total balance of all closed debts, including accrued interest, penalties and non-zero balances of closed debts.", comment: "HelloView"),
                      image: "history" + ImageSchemeHelper.selectSuffixForLocale(colorScheme: colorScheme)),
           HelloModel(id: 6,
                      title: NSLocalizedString("Now let's convert your data from the old format to the new format!", comment: "HelloView"),
                      text: NSLocalizedString("Since there were no payments before, to ensure the correct balance for new debts, one payment will be created in the amount of the difference between the original debt and the balance of the old debt at the time of data conversion.", comment: "HelloView"),
                      systemImage: "gearshape.2.fill"),
       ]
        
    }
    
    
}
