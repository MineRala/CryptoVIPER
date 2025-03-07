//
//  DetailContracts.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 7.03.2025.
//

import Foundation

// MARK: - DetailPresenterProtocol
protocol DetailPresenterProtocol {
    func load()
}

// MARK: - DetailViewProtocol
protocol DetailViewProtocol: AnyObject {
    func update(_ model: Crypto)
}
