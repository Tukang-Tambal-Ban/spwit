//
//  AmountSettlementRouterProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

import UIKit

protocol AmountSettlementRouterProtocol {

}

class AmountSettlementRouter: AmountSettlementRouterProtocol, RouterInjectable {
    var router: Router?

    init(router: Router) {
        self.router = router
    }

    static func createModule(router: Router) -> UIViewController {
        let view = AmountSettlementViewController()
        let interactor = AmountSettlementInteractor()
        let router = AmountSettlementRouter(router: router)
        let presenter = AmountSettlementPresenter(
            view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }

}
