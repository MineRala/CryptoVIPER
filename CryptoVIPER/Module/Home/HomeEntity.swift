//
//  HomeEntity.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 4.02.2023.
//

import Foundation

struct Crypto: Codable, Equatable {
    let currency: String
    let price: String
}

// UI' a Entity gönderilmez, Presentation modeli gönderilir. Presenterda entitiyi prsentation model'e convert ediyoruz.
struct CryptoPresentation: Equatable {
    let currency: String
    let price: String

    init(crypto: Crypto) {
        self.currency = crypto.currency
        self.price = crypto.price
    }
}
