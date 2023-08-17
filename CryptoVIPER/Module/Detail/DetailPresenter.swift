//
//  DetailPresenter.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 16.08.2023.
//

import Foundation

protocol DetailPresenterInterface: AnyObject {
    
}

class DetailPresenter: DetailPresenterInterface {
    var view: DetailViewInterface?
    private let interactor: DetailInteractorInterface
    private let router: DetailRouterInput

    
    init(view: DetailViewInterface,
         interactor: DetailInteractorInterface,
         router: DetailRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
       
        
    }
}
