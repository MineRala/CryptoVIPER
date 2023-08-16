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

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    // Any kullanmamızın sebebi syntax.
    var entry: EntryPoint? { get }
    static func startExecution() -> AnyRouter
}

final class CryptoRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func startExecution() -> AnyRouter {
        let router = CryptoRouter()
        
        // Assign VIP
        var view: AnyView = CryptoViewController()
        var presenter: AnyPresenter = CryptoPresenter()
        var interactor: AnyInteractor = CryptoInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
