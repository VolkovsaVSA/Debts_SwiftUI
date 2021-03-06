//
//  MigrationManager.swift
//  Debts
//
//  Created by Sergei Volkov on 26.12.2021.
//

import Foundation

class MigrationManager: ObservableObject {

    struct MigrationLocalStrings {
        private init(){}
        static let perDay = NSLocalizedString("% per day", comment: "MigrationManager")
        static let perWeek = NSLocalizedString("% per week", comment: "MigrationManager")
        static let perMonth = NSLocalizedString("% per month", comment: "MigrationManager")
        static let perYear = NSLocalizedString("% per year", comment: "MigrationManager")
        static let thisPaymentWasCreated = NSLocalizedString("this payment was created in time migration data from old data 4.x app version", comment: "MigrationManager")
        static let debtorsFrstName = NSLocalizedString("Debtors first name", comment: "MigrationManager")
    }
    
    func convert(percentType: String) -> Int {
        switch percentType {
            case MigrationLocalStrings.perYear: return 0
            case MigrationLocalStrings.perMonth: return 1
            case MigrationLocalStrings.perWeek: return 2
            case MigrationLocalStrings.perDay: return 3
            default: return 0
        }
    }
    
    func convertDebtModel(debts: [Debt]) -> [DebtMigrationModel] {
        var newArray = [DebtMigrationModel]()
        debts.forEach { debt in
            let newDebt = DebtMigrationModel(name: debt.name,
                                             summ: debt.summ,
                                             date: debt.date,
                                             status: debt.status,
                                             comment: debt.comment,
                                             startDate: debt.startDate,
                                             percent: debt.percent,
                                             phone: debt.phone,
                                             email: debt.email,
                                             item1: debt.item1,
                                             item2: debt.item2,
                                             item3: debt.item3,
                                             item4: debt.item4,
                                             localID: debt.localID,
                                             endPayDate: debt.endPayDate,
                                             endPercentSumm: debt.endPercentSumm,
                                             userImage: debt.userImage,
                                             notificationID: debt.notificationID,
                                             notificationTitle: debt.notificationTitle,
                                             notificationBody: debt.notificationBody,
                                             notificationDate: debt.notificationDate,
                                             notificationRepeat: debt.notificationRepeat,
                                             notificationInterval: debt.notificationInterval,
                                             notificationAmountRepayment: debt.notificationAmountRepayment)
            newArray.append(newDebt)
        }
        return newArray
    }
    
    func LoadOldData() -> [Debt] {
        var debtsMass: [Debt] = []
        if let loadArray = NSArray(contentsOfFile: PathForSave.debtData) {
            debtsMass = []
            for itemArray in loadArray {
                let tempData = Debt(dictionary: itemArray as! NSDictionary)
                debtsMass.append(tempData)
            }
        }
        return debtsMass
    }
    func LoadOldHistory() -> [Debt] {
        var historyMass: [Debt] = []
        if let loadArray = NSArray(contentsOfFile: PathForSave.history) {
            historyMass = []
            for itemArray in loadArray {
                let tempData = Debt(dictionary: itemArray as! NSDictionary)
                historyMass.append(tempData)
            }
        }
        return historyMass
    }
    
    func createNewDebt(debtor: DebtorCD, oldDebt: DebtMigrationModel, debtsIsClosed: Bool) {
        var percentBalanceType = 0
        if Int(oldDebt.item3) ?? 0 > 0 {
            percentBalanceType = 1
        }
//
//        let formatter = NumberFormatter()
//        formatter.generatesDecimalNumbers = true
//        formatter.numberStyle = NumberFormatter.Style.decimal
//        let formattedNumber = formatter.number(from: oldDebt.item4.replaceComma()) as? NSDecimalNumber ?? 0
//        print(formattedNumber)
//        {
//            xa = formattedNumber
//
        let initialDebt: Decimal = abs(Decimal(Double(oldDebt.item4.replaceComma()) ?? oldDebt.summ))
//        print(initialDebt)
//        if oldDebt.item4 == "" {
//            initialDebt = abs(Decimal(oldDebt.summ))
//        } else {
//            initialDebt = abs(Decimal(Double(oldDebt.item4.replaceComma()) ?? 0))
//        }
        

        let newDebt = CDStack
            .shared
            .createDebt(context: CDStack.shared.persistentContainer.viewContext,
                        debtor: debtor,
                        initialDebt: NSDecimalNumber(decimal: initialDebt),
                        startDate: oldDebt.startDate,
                        endDate: oldDebt.date,
                        percent: NSDecimalNumber(floatLiteral: oldDebt.percent),
                        percentType: 0,
                        currencyCode: oldDebt.localID,
                        debtorStatus: oldDebt.status,
                        comment: oldDebt.comment,
                        percentBalanceType: Int16(percentBalanceType))
        
        if abs(oldDebt.summ) < abs(Double(oldDebt.item4.replaceComma()) ?? 0) {
            let debtAmount = abs(Double(oldDebt.item4.replaceComma()) ?? oldDebt.summ) - abs(oldDebt.summ)
//
//        if oldDebt.summ < Double(truncating: initialDebt as NSNumber) {
//            let debtAmount = Double(truncating: initialDebt as NSNumber) - oldDebt.summ
            CDStack
                .shared
                .createPayment(context: CDStack.shared.persistentContainer.viewContext,
                               debt: newDebt,
                               debtAmount: NSDecimalNumber(floatLiteral: debtAmount),
                               interestAmount: 0,
                               date: OldMyDateFormatter.fullDateAndTime().date(from: oldDebt.item2) ?? Date(),
                               type: 0,
                               comment: MigrationLocalStrings.thisPaymentWasCreated)
        }
        
        if debtsIsClosed {
            newDebt.closeDate = oldDebt.endPayDate
            newDebt.isClosed = true
            
            
            if newDebt.debtBalance > 0 {
                CDStack
                    .shared
                    .createPayment(context: CDStack.shared.persistentContainer.viewContext,
                                   debt: newDebt,
                                   debtAmount: NSDecimalNumber(decimal: newDebt.debtBalance),
                                   interestAmount: 0,
                                   date: oldDebt.endPayDate,
                                   type: 0,
                                   comment: MigrationLocalStrings.thisPaymentWasCreated)
            }
        }
        
    }
    
    func migrateDebts(debts: [DebtMigrationModel], debtsIsClosed: Bool) {
        
        debts.forEach { item in
            let debtors = CDStack.shared.fetchDebtors()
            var oldDebtor: DebtorCD!
            
            if debtors.contains(where: { existDebtor in

                if item.name.dropLast().contains(existDebtor.firstName) ||
                    (existDebtor.familyName != nil ? item.name.dropLast().contains(existDebtor.familyName!) : false)  {
                    oldDebtor = existDebtor
                    return true
                } else {
                    return false
                }
            }) {
                
                createNewDebt(debtor: oldDebtor, oldDebt: item, debtsIsClosed: debtsIsClosed)
                
            } else {
                
                let nameComponets = item.name.components(separatedBy: " ")
                
                var firstName: String!
                var familyName: String?
                
                if nameComponets.count > 2 {
                    familyName = nameComponets[0]
                    firstName = nameComponets[1]
                } else {
                    firstName = nameComponets.first ?? MigrationLocalStrings.debtorsFrstName
                }
                
                let newDebtor = CDStack.shared.createDebtor(context: CDStack.shared.persistentContainer.viewContext,
                                                            firstName: firstName,
                                                            familyName: familyName,
                                                            phone: item.phone,
                                                            email: item.email,
                                                            imageData: item.userImage)
                
                createNewDebt(debtor: newDebtor, oldDebt: item, debtsIsClosed: debtsIsClosed)
            }
            
        }
        CDStack.shared.saveContext(context: CDStack.shared.persistentContainer.viewContext)
        DebtsViewModel.shared.refreshData()
    }
    
}
