//
//  SimplifyRouterProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

import UIKit

protocol SimplifyRouterProtocol {

}

class SimplifyRouter: SimplifyRouterProtocol, RouterInjectable {
    var router: Router?

    init(router: Router) {
        self.router = router
    }

    static func createModule(router: Router) -> UIViewController {
        let view = SimplifyViewController()
        let interactor = SimplifyInteractor()
        let router = SimplifyRouter(router: router)
        let presenter = SimplifyPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }

}
