//
//  ManageSettlementRouterProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

import UIKit

protocol ManageSettlementRouterProtocol {

}

class ManageSettlementRouter: ManageSettlementRouterProtocol, RouterInjectable {
    var router: Router?

    init(router: Router) {
        self.router = router
    }

    static func createModule(router: Router) -> UIViewController {
        let view = ManageSettlementViewController()
        let interactor = ManageSettlementInteractor()
        let router = ManageSettlementRouter(router: router)
        let presenter = ManageSettlementPresenter(
            view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }

}
