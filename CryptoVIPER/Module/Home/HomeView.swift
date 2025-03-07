//
//  HomeView.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 4.02.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        table.dataSource = self
        table.delegate = self
        return table
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    var presenter: HomePresenterProtocol!
    private var cryptos: [CryptoPresentation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        presenter.load()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.width/2 - 150, y: view.frame.height/2 - 25, width: 300, height: 80)
        activityIndicator.center = view.center
    }

}

// MARK: - Private
extension HomeViewController {
    private func addSubViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        view.addSubview(activityIndicator)
    }

    private func handleLoading(_ isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }

    private func handleCryptoList(_ cryptos: [CryptoPresentation]) {
        self.cryptos = cryptos
        self.updateVisibility(isDataVisible: true)
        self.tableView.reloadData()
    }

    private func handleError(_ error: String) {
        self.cryptos = []
        self.messageLabel.text = error
        self.updateVisibility(isDataVisible: false)
    }

    private func updateVisibility(isDataVisible: Bool) {
        self.tableView.isHidden = !isDataVisible
        self.messageLabel.isHidden = isDataVisible
    }
}

// MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func handleOutput(_ output: HomePresenterOutput) {
        DispatchQueue.main.async {
            switch output {
            case .setLoading(let isLoading):
                self.handleLoading(isLoading)
            case .showCryptoList(let cryptos):
                self.handleCryptoList(cryptos)
            case .showError(let error):
                self.handleError(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cryptos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = cryptos[indexPath.row].price
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.selectCrypto(at: indexPath.row)
    }
}
