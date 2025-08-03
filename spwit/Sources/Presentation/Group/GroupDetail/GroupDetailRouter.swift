//
//  GroupDetailRouterProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

import UIKit

protocol GroupDetailRouterProtocol {

}

class GroupDetailRouter: GroupDetailRouterProtocol, RouterInjectable {
    var router: Router?

    init(router: Router) {
        self.router = router
    }

    static func createModule(router: Router) -> UIViewController {
        let view = GroupDetailViewController()
        let interactor = GroupDetailInteractor()
        let router = GroupDetailRouter(router: router)
        let presenter = GroupDetailPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }

}
