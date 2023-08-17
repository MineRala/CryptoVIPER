//
//  HomePresenter.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 4.02.2023.
//

import UIKit

// talks to -> interactor, router, view
// Class, protocol

enum NetworkError: Error {
    case networkFailed
    case parsingFailed
    case invalidServerResponse
}
  
protocol HomePresenterInput: AnyObject {
    var router: HomeRouterInterface? { get set }
    var interactor: HomeInteractorInterface? { get set }
    var view: HomeViewInterface? { get set }
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>)
    func viewDidLoad()
    func onTapCell(model: Crypto, viewController: UIViewController)
}

final class CryptoPresenter: HomePresenterInput {
    var router: HomeRouterInterface?
    var view: HomeViewInterface?
    var interactor: HomeInteractorInterface? {
        didSet {
            // Completion için kullanılıyor.
           // interactor?.downloadCryptos()
           
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
    
    func viewDidLoad() {
        Task {
            do {
                guard let cryptos: [Crypto] = try await interactor?.downloadCryptos() else { return }
                view?.update(with: cryptos)
            } catch {
                view?.update(with: "Try again later")
            }
        }
    }
    
    func onTapCell(model: Crypto, viewController: UIViewController) {
        router?.goToDetail(model: model, viewController: viewController)
    }
}
