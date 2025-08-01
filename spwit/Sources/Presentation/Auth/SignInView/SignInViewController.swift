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
    private let ctaLabel = UILabel()
    private let logoApp =  UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        
        view.backgroundColor = UIColor(hex: "#0F213C")
        
        logoApp.image = UIImage(named: "spwit_logo")
        logoApp.contentMode = .scaleAspectFit
        logoApp.translatesAutoresizingMaskIntoConstraints = false
        
        ctaLabel.text = "Let's get started"
        ctaLabel.textColor = UIColor(hex: "A4F000")
        ctaLabel.textAlignment = .center
        ctaLabel.numberOfLines = 0
        ctaLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        sign in Button
        let appleIcon = UIImage(systemName: "apple.logo")
        signInButton.setImage(appleIcon, for: .normal)
        signInButton.tintColor = .black // or your preferred color
        signInButton.setTitle(" Sign In With Apple", for: .normal)
        signInButton.setTitleColor(.black, for: .normal) // <-- Use black or your desired color
        signInButton.backgroundColor = .white
        signInButton.layer.borderColor = UIColor.black.cgColor
        signInButton.layer.cornerRadius = 24
        signInButton.clipsToBounds = true
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        signInButton.translatesAutoresizingMaskIntoConstraints = false


 
        
        // Setup Result Label
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
        resultLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(ctaLabel)
        view.addSubview(signInButton)
        view.addSubview(resultLabel)
        view.addSubview(logoApp)
       

        NSLayoutConstraint.activate([
            
            logoApp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoApp.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -103),
            logoApp.widthAnchor.constraint(equalToConstant: 279),
            logoApp.heightAnchor.constraint(equalToConstant: 120),
            
            ctaLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ctaLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ctaLabel.bottomAnchor.constraint(equalTo: signInButton.topAnchor,constant: -20),
            
            signInButton.widthAnchor.constraint(equalToConstant: 360),   // width: 200 pts
            signInButton.heightAnchor.constraint(equalToConstant: 48) ,
            
            signInButton.widthAnchor.constraint(equalToConstant: 360),   // width: 200 pts
            signInButton.heightAnchor.constraint(equalToConstant: 50) ,   // height: 48 pts
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -237),

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


#if DEBUG
import SwiftUI

struct SignInViewControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SignInViewController {
        return SignInViewController()
    }
    func updateUIViewController(_ uiViewController: SignInViewController, context: Context) {}
}

struct SignInViewController_Previews: PreviewProvider {
    static var previews: some View {
        SignInViewControllerPreview()
            .edgesIgnoringSafeArea(.all)
            .previewDisplayName("UIKit: Sign In Screen")
    }
}
#endif
