//
//  HomeRouter.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 4.02.2023.
//

import UIKit

final class HomeRouter {
    unowned let view: UIViewController

    init(view: UIViewController) {
        self.view = view
    }
}

// MARK: - HomeRouterProtocol
extension HomeRouter: HomeRouterProtocol {
    func navigate(to route: HomeRoute) {
        switch route {
        case .detail(let crypto):
            let detailView = DetailBuilder.build(with: crypto)
            view.present(detailView, animated: true)
        }
    }
}
