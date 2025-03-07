//
//  Endpoint.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 7.03.2025.
//

import Foundation

enum Endpoint {
    enum Constant {
        static let baseURL = "https://raw.githubusercontent.com/atilsamancioglu/IA32-CryptoComposeData/main/cryptolist.json"
    }

    case cryptoModel

    var url: URL? {
        switch self {
        case .cryptoModel:
            return URL(string: Constant.baseURL)

        }
    }
}
