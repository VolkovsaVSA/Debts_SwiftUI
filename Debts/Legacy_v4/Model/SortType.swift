//
//  SortType.swift
//  Debts
//
//  Created by Sergey Volkov on 20.10.2019.
//  Copyright © 2019 Sergey Volkov. All rights reserved.
//

import Foundation

enum SortType: String {
    case AZ
    case ZA
    case Debt19
    case Debt91
    case StartDatePF
    case StartDateFP
    case EndDatePF
    case EndDateFP
    
    enum SortTypeName: String {
        case NameIncrase
        case NameDecrase
        case DebtIncrase
        case DebtDecrase
        case StartDateIncrase
        case StartDateDecrase
        case EndDateIncrase
        case EndDateDecrase
    }
    
    enum SortTypeNitofication: String {
        case SortTypeDidselect
    }
}

let SortTypeUDkey = "SortType"

var SortPopupArray = [SortModelPopup(name: .NameIncrase, type: .AZ, checkmark: false),
           SortModelPopup(name: .DebtIncrase, type: .Debt19, checkmark: false),
           SortModelPopup(name: .StartDateIncrase, type: .StartDatePF, checkmark: false),
           SortModelPopup(name: .EndDateIncrase, type: .EndDatePF, checkmark: false)
]

func sortDebtMass( arr: inout [Debt]) {
    var tempDebtmass = arr
    
    let sortType = UserDefaults.standard.string(forKey: SortTypeUDkey)
    switch sortType {
    case SortType.AZ.rawValue:
        tempDebtmass = arr.sorted(by: { (first, second) -> Bool in
            first.name < second.name
        });
        SortPopupArray[0].name = .NameIncrase;
        SortPopupArray[0].type = .AZ;
        SortPopupArray[0].checkmark = true
    case SortType.ZA.rawValue:
        tempDebtmass = arr.sorted(by: { (first, second) -> Bool in
            first.name > second.name
        });
        SortPopupArray[0].name = .NameDecrase;
        SortPopupArray[0].type = .ZA;
        SortPopupArray[0].checkmark = true
    case SortType.Debt19.rawValue:
        tempDebtmass = arr.sorted(by: { (first, second) -> Bool in
            first.summ < second.summ
        });
        SortPopupArray[1].name = .DebtIncrase;
        SortPopupArray[1].type = .Debt19;
        SortPopupArray[1].checkmark = true
    case SortType.Debt91.rawValue:
        tempDebtmass = arr.sorted(by: { (first, second) -> Bool in
            first.summ > second.summ
        });
        SortPopupArray[1].name = .DebtDecrase;
        SortPopupArray[1].type = .Debt91;
        SortPopupArray[1].checkmark = true
    case SortType.StartDatePF.rawValue:
        tempDebtmass = arr.sorted(by: { (first, second) -> Bool in
            first.startDate < second.startDate
        });
        SortPopupArray[2].name = .StartDateIncrase;
        SortPopupArray[2].type = .StartDatePF;
        SortPopupArray[2].checkmark = true
    case SortType.StartDateFP.rawValue:
        tempDebtmass = arr.sorted(by: { (first, second) -> Bool in
            first.startDate > second.startDate
        });
        SortPopupArray[2].name = .StartDateDecrase;
        SortPopupArray[2].type = .StartDateFP;
        SortPopupArray[2].checkmark = true
    case SortType.EndDatePF.rawValue:
        tempDebtmass = arr.sorted(by: { (first, second) -> Bool in
            first.date < second.date
        });
        SortPopupArray[3].name = .EndDateIncrase;
        SortPopupArray[3].type = .EndDatePF;
        SortPopupArray[3].checkmark = true
    case SortType.EndDateFP.rawValue:
        tempDebtmass = arr.sorted(by: { (first, second) -> Bool in
            first.date > second.date
        });
        SortPopupArray[3].name = .EndDateDecrase;
        SortPopupArray[3].type = .EndDateFP;
        SortPopupArray[3].checkmark = true
    default: break
    }
    
    arr = tempDebtmass
}
