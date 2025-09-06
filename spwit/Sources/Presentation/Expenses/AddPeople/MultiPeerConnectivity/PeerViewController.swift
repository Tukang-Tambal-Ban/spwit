//
//  PeerViewController.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 9/6/25.
//


import UIKit

final class PeerViewController: UIViewController {
    var presenter: PeerPresenterProtocol?

    private let label = UILabel()
    private let button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0

        button.setTitle("Send My Info", for: .normal)
        button.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)

        view.addSubview(label)
        view.addSubview(button)
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20)
        ])
    }

    @objc private func sendTapped() {
        presenter?.didTapSend()
    }
}

extension PeerViewController: PeerViewProtocol {
    func showReceivedPeer(_ user: PeerUser) {
        label.text = "Received user:\n\(user.name)\n\(user.email)"
    }
}
