//
//  Persistence.swift
//  Debts
//
//  Created by Sergei Volkov on 01.03.2021.
//

import CoreData

struct CDStack {
    
//    struct Preview {
//        static let result = CDStack(inMemory: true)
//        static let viewContext = result.container.viewContext
//
//        static var preview: CDStack = {
//            var previewDebtor1: DebtorCD = {
//                let newDebtor = DebtorCD(context: viewContext)
//                newDebtor.firstName = "John"
//                newDebtor.familyName = "Connor"
//                return newDebtor
//            }()
//            var previewDebtor2: DebtorCD = {
//                let newDebtor = DebtorCD(context: viewContext)
//                newDebtor.firstName = "Sarah"
//                newDebtor.familyName = "Connor"
//                return newDebtor
//            }()
//            var previewDebt1: DebtCD = {
//                let newDebt = DebtCD(context: viewContext)
//                newDebt.debtor = previewDebtor1
//                newDebt.balanceOfDebt = 100
//                newDebt.initialDebt = 100
//                return newDebt
//            }()
//            var previewDebt2: DebtCD = {
//                let newDebt = DebtCD(context: viewContext)
//                newDebt.debtor = previewDebtor1
//                newDebt.balanceOfDebt = 543
//                newDebt.initialDebt = 1000
//                return newDebt
//            }()
//            var previewDebt3: DebtCD = {
//                let newDebt = DebtCD(context: viewContext)
//                newDebt.debtor = previewDebtor2
//                newDebt.balanceOfDebt = 400
//                newDebt.initialDebt = 100
//                newDebt.percent = 5
//                newDebt.percentType = 0
//                return newDebt
//            }()
//
//            do {
//                try viewContext.save()
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//            return result
//        }()
//
//        static func fetchDebts()->[DebtCD] {
//            var items = [DebtCD]()
//            do {
//                items = try preview.viewContext.fetch(DebtCD.fetchRequest())
//            } catch {
//                print("fetch error \(error.localizedDescription)")
//            }
//            return items
//        }
//        func fetchDebtors()->[DebtorCD] {
//            var items = [DebtorCD]()
//            do {
//                items = try preview.viewContext.fetch(DebtorCD.fetchRequest())
//            } catch {
//                print("fetch error \(error.localizedDescription)")
//            }
//            return items
//        }
//
//    }
    
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
    
    func fetchDebts()->[DebtCD] {
        var items = [DebtCD]()
        do {
            items = try container.viewContext.fetch(DebtCD.fetchRequest())
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

    func createDebtor(context: NSManagedObjectContext, firstName: String, familyName: String?, phone: String?, email: String?)->DebtorCD {
        let debtor = DebtorCD(context: context)
        debtor.firstName = firstName
        debtor.familyName = familyName
        debtor.phone = phone
        debtor.email = email
        return debtor
    }
    func createDebt(context: NSManagedObjectContext, debtor: DebtorCD, initialDebt: NSDecimalNumber, startDate: Date?, endDate: Date?, percent: NSDecimalNumber, percentType: Int16, currencyCode: String, debtorStatus: String, comment: String?)->DebtCD {
        
        let debt = DebtCD(context: context)
        debt.initialDebt = initialDebt
        debt.balanceOfDebt = initialDebt
        debt.startDate = startDate
        debt.endDate = endDate
        debt.percent = percent
        debt.percentType = percentType
        debt.currencyCode = currencyCode
        debt.debtorStatus = debtorStatus
        debt.comment = comment
        debt.debtor = debtor
        return debt
    }
    
}
