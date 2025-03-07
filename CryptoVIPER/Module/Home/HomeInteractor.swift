//
//  HomeInteractor.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 4.02.2023.
//

import Foundation

final class HomeInteractor {
    weak var delegate: HomeInteractorDelegate?
    private let networkManager: NetworkManagerProtocol
    private var cryptos: [Crypto] = []

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

// MARK: - HomeInteractorProtocol
extension HomeInteractor: HomeInteractorProtocol {
    func load() async {
        delegate?.handleOutput(.setLoading(true))

        do {
            let cryptos: [Crypto] = try await networkManager.makeRequest(endpoint: .cryptoModel, type: [Crypto].self)
            try await Task.sleep(nanoseconds: 1_000_000_000)
            self.cryptos = cryptos
            delegate?.handleOutput(.setLoading(false))
            delegate?.handleOutput(.showCryptoList(cryptos))
        } catch let error as CRError {
            delegate?.handleOutput(.setLoading(false))
            delegate?.handleOutput(.showError(error.rawValue))
        } catch {
            delegate?.handleOutput(.setLoading(false))
            delegate?.handleOutput(.showError("Unowned Error:: \(error.localizedDescription)"))
        }
    }

    func selectCrypto(at index: Int) {
        delegate?.handleOutput(.showCryptoDetail(cryptos[index]))
    }
}
