//
//  DetailPresenter.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 16.08.2023.
//

import Foundation

final class DetailPresenter {
    private unowned var view: DetailViewProtocol
    private let crypto: Crypto

    init(view: DetailViewProtocol, crypto: Crypto) {
        self.view = view
        self.crypto = crypto
    }
}

// MARK: - DetailPresenterProtocol
extension DetailPresenter: DetailPresenterProtocol {
    func load() {
        view.update(crypto)
    }
}
