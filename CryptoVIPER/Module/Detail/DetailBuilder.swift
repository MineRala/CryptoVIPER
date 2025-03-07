//
//  DetailBuilder.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 7.03.2025.
//

import UIKit

final class DetailBuilder {
    static func build(with crypto: Crypto) -> UIViewController {
        let viewController = DetailViewController()
        let presenter = DetailPresenter(view: viewController, crypto: crypto)
        viewController.presenter = presenter
        return viewController
    }
}
