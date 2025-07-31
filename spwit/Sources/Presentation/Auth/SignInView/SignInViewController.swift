//
//  SignInViewController.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//


import UIKit

class SignInViewController: UIViewController, SignInViewProtocol {
    var presenter: SignInPresenterProtocol?

    private let signInButton = UIButton(type: .system)
    private let resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        // Setup Button
        signInButton.setTitle("Sign in with Apple", for: .normal)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        signInButton.translatesAutoresizingMaskIntoConstraints = false

        // Setup Result Label
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
        resultLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(signInButton)
        view.addSubview(resultLabel)

        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            resultLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    @objc private func signInTapped() {
        presenter?.signInTapped()
    }

    func showResult(from entity: SignInEntity) {
        resultLabel.text = """
        ✅ Sign In Success

        User ID: \(entity.userId)
        Apple ID: \(entity.appleId)
        Username: \(entity.username)
        Email: \(entity.email)
        Token: \(entity.token.prefix(10))...
        """
    }

    func showError(_ error: Error) {
        resultLabel.text = "❌ Error: \(error.localizedDescription)"
    }

    func showLoading() {
        resultLabel.text = "🔄 Signing in..."
    }

    func hideLoading() {
        // You could reset or do nothing
    }
}