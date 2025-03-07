//
//  DetailView.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 16.08.2023.
//

import UIKit

final class DetailViewController: UIViewController {
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

    var presenter: DetailPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.load()
    }
}

// MARK: - UI
extension DetailViewController {
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

// MARK: - DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    func update(_ model: Crypto) {
        currencyLabel.text = model.currency
        priceLabel.text = model.price
    }
}
