//
//  HomeContracts.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 7.03.2025.
//

import Foundation

// MARK: - Interactor
protocol HomeInteractorProtocol: AnyObject {
    var delegate: HomeInteractorDelegate? { get set }
    func load() async
    func selectCrypto(at index: Int)
}

enum HomeInteractorOutput {
    case setLoading(Bool)
    case showCryptoList([Crypto])
    case showError(String)
    case showCryptoDetail(Crypto)
}

protocol HomeInteractorDelegate: AnyObject {
    func handleOutput(_ output: HomeInteractorOutput)
}

// MARK: - Presenter
protocol HomePresenterProtocol: AnyObject {
    func load()
    func selectCrypto(at index: Int)
}

enum HomePresenterOutput {
    case setLoading(Bool)
    case showCryptoList([CryptoPresentation])
    case showError(String)
}

// MARK: - View
protocol HomeViewProtocol: AnyObject {
    func handleOutput(_ output: HomePresenterOutput)
}

// MARK: - Router
enum HomeRoute {
    case detail(Crypto)
}

protocol HomeRouterProtocol: AnyObject {
    func navigate(to route: HomeRoute)
}
