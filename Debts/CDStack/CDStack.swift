//
//  Persistence.swift
//  Debts
//
//  Created by Sergei Volkov on 01.03.2021.
//

import CoreData

struct CDStack {
    
    static let shared = CDStack()
    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Debts")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("CDError: \(error.localizedDescription)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveContext (context: NSManagedObjectContext) {
        DispatchQueue.main.async {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    context.rollback()
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
    func fetchDebts(isClosed: Bool)->[DebtCD] {
        var items = [DebtCD]()
        do {
            items = try container.viewContext.fetch(DebtCD.fetchRequest(isClosed: isClosed))
        } catch {
            print("fetch error \(error.localizedDescription)")
        }
        return items
    }
    func fetchDebtors()->[DebtorCD] {
        var items = [DebtorCD]()
        do {
            items = try container.viewContext.fetch(DebtorCD.fetchRequest())
        } catch {
            print("fetch error \(error.localizedDescription)")
        }
        return items
    }

    func createDebtor(context: NSManagedObjectContext, firstName: String, familyName: String?, phone: String?, email: String?, image: Data?)->DebtorCD {
        let debtor = DebtorCD(context: context)
        debtor.firstName = firstName
        debtor.familyName = familyName
        debtor.phone = phone
        debtor.email = email
        debtor.image = image as NSData?
        return debtor
    }
    func createDebt(context: NSManagedObjectContext, debtor: DebtorCD, initialDebt: NSDecimalNumber, startDate: Date?, endDate: Date?, percent: NSDecimalNumber, percentType: Int16, currencyCode: String, debtorStatus: String, comment: String, percentBalanceType: Int16)->DebtCD {
        
        let debt = DebtCD(context: context)
        debt.id = UUID()
        debt.initialDebt = initialDebt
        debt.startDate = startDate
        debt.endDate = endDate
        debt.percent = percent
        debt.percentType = percentType
        debt.percentBalanceType = percentBalanceType
        debt.currencyCode = currencyCode
        debt.debtorStatus = debtorStatus
        debt.comment = comment
        debt.debtor = debtor
        debt.isClosed = false
        return debt
    }
    func createPayment(context: NSManagedObjectContext, debt: DebtCD, debtAmount: NSDecimalNumber, interestAmount: NSDecimalNumber, date: Date, type: Int16, comment: String) {
        let payment = PaymentCD(context: context)
        payment.paymentDebt = debtAmount
        payment.paymentPercent = interestAmount
        payment.date = date
        payment.type = type
        payment.debt = debt
        payment.comment = comment
    }
    
}
