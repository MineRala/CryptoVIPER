//
//  DetailView.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 16.08.2023.
//

import UIKit

protocol DetailViewInterface: AnyObject {
    var presenter: DetailPresenterInterface? { get set }
}

final class DetailViewController: UIViewController, DetailViewInterface {
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        stackView.addArrangedSubview(currencyLabel)
        stackView.addArrangedSubview(priceLabel)
        return stackView
    }()
    
    var presenter: DetailPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    public init(_ model: Crypto) {
        super.init(nibName: nil, bundle: nil)
        setText(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setText(model: Crypto) {
        currencyLabel.text = model.currency
        priceLabel.text = model.price
    }
}
