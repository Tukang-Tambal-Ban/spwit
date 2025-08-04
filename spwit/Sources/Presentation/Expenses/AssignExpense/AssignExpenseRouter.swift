//
//  AssignExpenseRouterProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

import UIKit

protocol AssignExpenseRouterProtocol {

}

class AssignExpenseRouter: AssignExpenseRouterProtocol, RouterInjectable {
    var router: Router?

    init(router: Router) {
        self.router = router
    }

    static func createModule(router: Router) -> UIViewController {
        let view = AssignExpenseViewController()
        let interactor = AssignExpenseInteractor()
        let router = AssignExpenseRouter(router: router)
        let presenter = AssignExpensePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }

}
