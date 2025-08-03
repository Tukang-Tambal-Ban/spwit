//
//  ProfileRouterProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

import UIKit

protocol ProfileRouterProtocol {

}

class ProfileRouter: ProfileRouterProtocol, RouterInjectable {
    var router: Router?

    init(router: Router) {
        self.router = router
    }

    static func createModule(router: Router) -> UIViewController {
        let view = ProfileViewController()
        let interactor = ProfileInteractor()
        let router = ProfileRouter(router: router)
        let presenter = ProfilePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }

}
