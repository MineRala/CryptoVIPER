//
//  HomeView.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 4.02.2023.
//

import Foundation
import UIKit

// Talks to -> presenter
// Class, protocol

protocol HomeViewInterface: AnyObject {
    var presenter: HomePresenterInput? { get set }
    
    func update(with cryptos: [Crypto])
    func update(with error: String)
}

final class CryptoViewController: UIViewController, HomeViewInterface {
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
        label.text = "Downloading.."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    weak var presenter: HomePresenterInput?
    var cryptos: [Crypto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        presenter?.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Subviewler eklenince çağırılır
        // Subviewler eklendikten sonra yapılcak işlemleri burada yapmalıyız
        tableView.frame = view.bounds
        // message label tam ortada olacak o yüzden yarısını çıkartmamız lazım
        messageLabel.frame = CGRect(x: view.frame.width/2 - 100, y: view.frame.height/2 - 25, width: 200, height: 50)
    }
        
    func update(with cryptos: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptos = cryptos
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.cryptos = []
            self.tableView.isHidden = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
        }
    }
}

extension CryptoViewController: UITableViewDataSource {
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

extension CryptoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.onTapCell(model: cryptos[indexPath.row], viewController: self)
    }
}
