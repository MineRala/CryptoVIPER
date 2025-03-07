//
//  HomePresenter.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 4.02.2023.
//

import UIKit

final class HomePresenter {
    private unowned var view: HomeViewProtocol
    private let interactor: HomeInteractorProtocol
    private let router: HomeRouterProtocol

    init(view: HomeViewProtocol, interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.interactor.delegate = self
    }
}

// MARK: - HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    func load() {
        Task { await interactor.load() }
    }
    
    func selectCrypto(at index: Int) {
        interactor.selectCrypto(at: index)
    }
}

// MARK: - HomePresenterOutput
extension HomePresenter: HomeInteractorDelegate {
    func handleOutput(_ output: HomeInteractorOutput) {
        switch output {
        case .setLoading(let bool):
            view.handleOutput(.setLoading(bool))
        case .showCryptoList(let cryptos):
            let cryptoPresentations = cryptos.map( CryptoPresentation.init)
            view.handleOutput(.showCryptoList(cryptoPresentations))
        case .showError(let error):
            view.handleOutput(.showError(error))
        case .showCryptoDetail(let crypto):
            router.navigate(to: .detail(crypto))
        }
    }
}
