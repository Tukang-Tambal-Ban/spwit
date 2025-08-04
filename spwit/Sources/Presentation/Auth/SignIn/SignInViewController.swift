//
//  SignInViewController.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//


import UIKit

class SignInViewController: UIViewController, SignInViewProtocol {
    var presenter: SignInPresenterProtocol?
    private var appleSignInService: AppleSignInService?

    private let signInButton = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView()
    private let resultLabel = UILabel()
    private let ctaLabel = UILabel()
    private let logoApp =  UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        
        view.backgroundColor = .darkBlue
        
        logoApp.image = Images.spwitLogo
        logoApp.contentMode = .scaleAspectFit
        logoApp.translatesAutoresizingMaskIntoConstraints = false
        
        ctaLabel.text = "Let's get started"
        ctaLabel.applyStyle(Fonts.callout.regular, color: .lightGreen)
        ctaLabel.textAlignment = .center
        ctaLabel.numberOfLines = 0
        ctaLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        sign in Button
        let appleIcon = Icons.appleLogo
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
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        
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
        appleSignInService = AppleSignInService(delegate: self, presentationAnchor: view.window)
          appleSignInService?.startSignInWithAppleFlow()
    }

    func showError(_ error: Error) {
        print("error: \(error)")
    }

    func showLoading() {
        signInButton.setTitle(nil, for: .normal)
        signInButton.setImage(nil, for: .normal)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        signInButton.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: signInButton.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
        signInButton.isEnabled = false
    }

    func hideLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        
        signInButton.setImage(Icons.appleLogo, for: .normal)
        signInButton.setTitle(" Sign In With Apple", for: .normal)
        signInButton.isEnabled = true
    }
    
}

extension SignInViewController: AppleSignInServiceDelegate {
    func didReceiveAppleSignIn(success: SignInRequestEntity) {
        presenter?.signIn(with: success)
    }

    func didFailAppleSignIn(error: Error) {
        showError(error)
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
