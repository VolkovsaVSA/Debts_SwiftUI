//
//  Persistence.swift
//  Debts
//
//  Created by Sergei Volkov on 01.03.2021.
//

import CoreData
import WidgetKit

struct CDStack {
    static let shared = CDStack()

    let persistentContainer: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentCloudKitContainer(name: "Debts")

        if let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.VSA.Debts") {
            let storeURL = container.appendingPathComponent("Debts.sqlite")
            let description = NSPersistentStoreDescription(url: storeURL)
            persistentContainer.persistentStoreDescriptions = [description]
        }
        
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        persistentContainer.persistentStoreDescriptions.forEach {
            
            $0.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
            $0.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)

            if !UserDefaults.standard.bool(forKey: UDKeys.iCloudSync) {
                $0.cloudKitContainerOptions = nil
            }
//            else {
//                $0.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.VSA.Debts")
//            }
        }

        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("CDError: \(error.localizedDescription)")
            }
        })
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func clearDatabase() {
        guard let url = persistentContainer.persistentStoreDescriptions.first?.url else { return }
        
        let persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator

         do {
             try persistentStoreCoordinator.destroyPersistentStore(at:url, ofType: NSSQLiteStoreType, options: nil)
             try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
         } catch {
             print("Attempted to clear persistent store: " + error.localizedDescription)
         }
    }
    
    func saveContext (context: NSManagedObjectContext) {
        DispatchQueue.main.async {
            if context.hasChanges {
                do {
                    try context.save()
                    WidgetCenter.shared.reloadAllTimelines()
                } catch {
                    context.rollback()
                    let nserror = error as NSError
                    print("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }

    
    func fetchDebts(isClosed: Bool)->[DebtCD] {
        var items = [DebtCD]()
        do {
            items = try persistentContainer.viewContext.fetch(DebtCD.fetchRequest(isClosed: isClosed))
        } catch {
            print("fetch error \(error.localizedDescription)")
        }
        return items
    }
    func fetchDebtors()->[DebtorCD] {
        var items = [DebtorCD]()
        do {
            items = try persistentContainer.viewContext.fetch(DebtorCD.fetchRequest())
        } catch {
            print("fetch error \(error.localizedDescription)")
        }
        return items
    }

    func createDebtor(context: NSManagedObjectContext, firstName: String, familyName: String?, phone: String?, email: String?, imageData: Data?)->DebtorCD {
        let debtor = DebtorCD(context: context)
        debtor.firstName = firstName
        debtor.familyName = familyName
        debtor.phone = phone
        debtor.email = email
        debtor.image = imageData
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
