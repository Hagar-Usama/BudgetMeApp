//
//  STAccount.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

typealias DateTime = String

struct STAccount: Decodable, Equatable {
    let accountUid: String
    let defaultCategory: String
    let currency: STCurrency
    let createdAt: DateTime
}

struct STBalance: Decodable, Equatable {
    let clearedBalance: CurrencyAndAmount
    let effectiveBalance: CurrencyAndAmount
    let pendingTransactions: CurrencyAndAmount
    let acceptedOverdraft: CurrencyAndAmount
    let amount: CurrencyAndAmount
}
