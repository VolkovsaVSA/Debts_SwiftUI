//
//  StoreManager.swift
//  Debts
//
//  Created by Sergei Volkov on 18.12.2021.
//

import Foundation
import StoreKit

final class StoreManager: ObservableObject {
    static let shared = StoreManager()
    
    enum PurchaseError: Error {
        case failed, cancelled, pending, userCannotMakePayments, purchaseException
    }
    
    @Published private(set) var products: [Product]?

    private var transactionListener: Task<Void, Error>? = nil
    
    var priceFullVersion: String {
        if let unwrapProduct = products?.first {
            return unwrapProduct.displayPrice
        } else {
            return NSLocalizedString("n/a", comment: " ")
        }
    }
    
    init() {
        transactionListener = handleTransactions()
        Task.init {
            products = await requestProductsFromAppStore(productIds: [IAPProducts.fullVersion.rawValue])
            let result = try await isPurchased(IAPProducts.fullVersion.rawValue)
            UserDefaults.standard.set(result, forKey: IAPProducts.fullVersion.rawValue)
        }
    }
    
    deinit { transactionListener?.cancel() }
    
    @MainActor public func requestProductsFromAppStore(productIds: Set<String>) async -> [Product]? {
        try? await Product.products(for: productIds)
    }
    
    @MainActor public func purchase(_ product: Product) async throws -> Transaction? {
        
        guard AppStore.canMakePayments else { throw PurchaseError.userCannotMakePayments }
        guard let result = try? await product.purchase() else { throw PurchaseError.purchaseException }

        switch result {
            case .pending:
                throw PurchaseError.pending
            case .success(let verification):
                let transaction = try checkVerified(verification)
                await transaction.finish()
                UserDefaults.standard.set(true, forKey: IAPProducts.fullVersion.rawValue)
                return transaction
            case .userCancelled:
                throw PurchaseError.cancelled
            @unknown default:
                assertionFailure("Unexpected result")
                throw PurchaseError.failed
        }

    }
    
    @MainActor private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
            case .unverified:
                throw PurchaseError.failed
            case .verified(let safe):
                UserDefaults.standard.set(true, forKey: IAPProducts.fullVersion.rawValue)
                return safe
        }
    }

    private func handleTransactions() -> Task<Void, Error> {
        Task.detached {
            for await result in Transaction.updates {
                let transaction = try await self.checkVerified(result)
                await transaction.finish()
            }
        }
    }
    
    @MainActor private func isPurchased(_ productID: String) async throws -> Bool {
//        guard let result = await Transaction.latest(for: productID) else {
//            print(#line)
//            return false
//        }
//
        guard let result = await Transaction.currentEntitlement(for: productID) else {
            print(#line)
            return false
        }
        let transaction = try checkVerified(result)

        return transaction.revocationDate == nil
//        && !transaction.isUpgraded
    }
    
   
}

enum IAPProducts: String {
    case fullVersion = "Debts.FullVersion"
}
