//
//  HomePresenter.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 4.02.2023.
//

import Foundation

// talks to -> interactor, router, view
// Class, protocol

enum NetworkError: Error {
    case networkFailed
    case parsingFailed
    case invalidServerResponse
}
  
protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>)
}

final class CryptoPresenter: AnyPresenter {
    var router: AnyRouter?
    var view: AnyView?
    var interactor: AnyInteractor? {
        didSet {
            // Completion için kullanılıyor.
           // interactor?.downloadCryptos()
            Task {
                do {
                    guard let cryptos: [Crypto] = try await interactor?.downloadCryptos() else { return }
                    view?.update(with: cryptos)
                } catch {
                    view?.update(with: "Try again later")
                }
            }
        }
    }
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(_):
            view?.update(with: "Try again later...")
        }
    }
    
}
