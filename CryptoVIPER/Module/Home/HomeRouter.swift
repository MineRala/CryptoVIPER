//
//  HomeRouter.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 4.02.2023.
//

import Foundation
import UIKit

// talks to -> presenter
// Class, protocol
// EntryPoint -> Giriş noktası
// Uygulama ilk açıldığında nereye gidecek, hangi sayfalara gidilecek
// Uygulamayı organize eden class

typealias EntryPoint = HomeViewInterface & UIViewController

protocol HomeRouterInterface: AnyObject {
    var entry: EntryPoint? { get }
    static func startExecution() -> HomeRouterInterface
    func goToDetail(model: Crypto, viewController: UIViewController)
}

final class CryptoRouter: HomeRouterInterface {
    weak var entry: EntryPoint?
    
    static func startExecution() -> HomeRouterInterface {
        let router = CryptoRouter()
        
        // Assign VIP
        let view: HomeViewInterface = CryptoViewController()
        let presenter: HomePresenterInput = CryptoPresenter()
        let interactor: HomeInteractorInterface = CryptoInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    func goToDetail(model: Crypto, viewController: UIViewController) {
        let repoDetailVC = DetailRouter.createModule(model)
        viewController.present(repoDetailVC, animated: true, completion: nil)
    }
}
