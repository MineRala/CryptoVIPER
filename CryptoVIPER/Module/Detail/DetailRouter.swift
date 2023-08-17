//
//  DetailRouter.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 16.08.2023.
//

import UIKit

protocol DetailRouterInput: AnyObject {
    static func createModule(_ model: Crypto) -> DetailViewController
}

final class DetailRouter: DetailRouterInput {
    static func createModule(_ model: Crypto) -> DetailViewController {
        let view = DetailViewController(model)
        
        // Kullanılmadığı için şu anlık hiçbirine gerek yok
//        let interactor = DetailInteractor()
//        let router = DetailRouter()
//        let presenter = DetailPresenter.init(view: view,
//                                                 interactor: interactor,
//                                                 router: router)
//        view.presenter = presenter
        return view
    }
}
