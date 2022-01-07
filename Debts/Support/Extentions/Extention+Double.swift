//
//  Extention+Double.swift
//  Debts
//
//  Created by Sergei Volkov on 03.11.2021.
//

import Foundation

extension Double {
    func round(to decimalPlaces: Int) -> Double {
        let precisionNumber = pow(10,Double(decimalPlaces))
        var n = self // self is a current value of the Double that you will round
        n = n * precisionNumber
        n.round()
        n = n / precisionNumber
        return n
    }
}

func Rnd(_ x: Double) -> Decimal {
    let rnd = (x * 100).rounded(.toNearestOrEven)
    return (Decimal(rnd) / 100)
}
