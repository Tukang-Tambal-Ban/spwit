//
//  CreateGroupRouterProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

import UIKit

protocol CreateGroupRouterProtocol {

}

class CreateGroupRouter: CreateGroupRouterProtocol, RouterInjectable {
    var router: Router?

    init(router: Router) {
        self.router = router
    }

    static func createModule(router: Router) -> UIViewController {
        let view = CreateGroupViewController()
        let interactor = CreateGroupInteractor(groupUsecase: DIContainer.shared.groupUsecase)
        let router = CreateGroupRouter(router: router)
        let presenter = CreateGroupPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }

}
