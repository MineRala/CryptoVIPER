//
//  HomeViewBuilder.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 7.03.2025.
//

import UIKit

final class HomeBuilder {
    static func build() -> UIViewController {
        let homeViewController = HomeViewController()
        let interactor = HomeInteractor(networkManager: NetworkManager())
        let router = HomeRouter(view: homeViewController)
        let presenter = HomePresenter(view: homeViewController, interactor: interactor, router: router)

        homeViewController.presenter = presenter
        return homeViewController
    }
}
