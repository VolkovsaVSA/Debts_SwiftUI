//
//  PercentType.swift
//  Debts
//
//  Created by Sergei Volkov on 01.03.2021.
//

import Foundation

enum PercentType: Int, CaseIterable {
    case perYear, perMonth, perWeek, perDay
    
    static func percentTypeConvert(type: PercentType)->String {
        switch type {
        case .perYear: return NSLocalizedString("per year", comment: "")
        case .perMonth: return NSLocalizedString("per month", comment: "")
        case .perWeek: return NSLocalizedString("per week", comment: "")
        case .perDay: return NSLocalizedString("per day", comment: "")
        }
    }
}


/// interest calculation
//Как посчитать самостоятельно выплаты по займу
//
//Определить размер взноса в счет погашение долга перед финансовым учреждением можно вручную. Формула расчета аннуитетного платежа (А) представляет собой следующее соотношение: А=К*(П/(1+П)-М-1), где К – сумма кредита, П – процентная ставка, М – количество месяцев. Такой прием используют при подсчете выплат по ипотеке и потребительским займам.
//Дифференциальная система отличается уменьшением задолженности в период погашения долга. Для расчета можно воспользоваться формулой ДП = ОЗ / КП+ ОЗ х МС. ОЗ – остаток задолженности, КП – количество месяцев до погашения долга, МС – месячная ставка (поделить кредитную ставку на 12).


