//
//  AppleSignInServiceDelegate.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 02/08/25.
//


import Foundation
import AuthenticationServices
import UIKit

protocol AppleSignInServiceDelegate: AnyObject {
    func didReceiveAppleSignIn(success: SignInRequestEntity)
    func didFailAppleSignIn(error: Error)
}

final class AppleSignInService: NSObject {
    weak var delegate: AppleSignInServiceDelegate?
    private weak var presentationAnchor: ASPresentationAnchor?

    init(delegate: AppleSignInServiceDelegate, presentationAnchor: ASPresentationAnchor?) {
        self.delegate = delegate
        self.presentationAnchor = presentationAnchor
    }

    func startSignInWithAppleFlow() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

extension AppleSignInService: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }

        let identityToken = credential.identityToken.flatMap { String(data: $0, encoding: .utf8) }
        let userId = credential.user
        let name = credential.fullName
        let email = credential.email

        guard let token = identityToken else {
            delegate?.didFailAppleSignIn(error: NSError(domain: "AppleSignIn", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid token"]))
            return
        }
        
        print("token: \n" + token)
        print("userId: \n" + userId)
        print("name: \n" + ((name?.givenName ?? "") + " " + (name?.familyName ?? "")))
        print("email: \n" + (email ?? ""))

        let payload = SignInRequestEntity(identityToken: token, appleUserId: userId, name: ((name?.givenName ?? "") + " " + (name?.familyName ?? "")), email: email ?? "")
        delegate?.didReceiveAppleSignIn(success: payload)
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        delegate?.didFailAppleSignIn(error: error)
    }
}

extension AppleSignInService: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return presentationAnchor ?? UIWindow()
    }
}
