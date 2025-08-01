//
//  SignInRouterProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

import UIKit

protocol SignInRouterProtocol {
    func navigateToHomePage(_ signIn: SignInEntity)
}

class SignInRouter: SignInRouterProtocol, RouterInjectable {
    var router: Router?

    init(router: Router) {
        self.router = router
    }

    static func createModule(router: Router) -> UIViewController {
        let view = SignInViewController()
        let interactor = SignInInteractor(authUsecase: DIContainer.shared.authUsecase)
        let router = SignInRouter(router: router)
        let presenter = SignInPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
    
    
    func navigateToHomePage(_ signIn: SignInEntity) {
        guard let sceneNavigator = router else { return }
        
        // Create Scene B View Controller
        let HomePageViewController = HomePageRouter.createModule(router: sceneNavigator, for: signIn)
        sceneNavigator.setRootViewController(HomePageViewController)
    }
}
