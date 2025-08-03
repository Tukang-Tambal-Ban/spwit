//
//  GroupSettingRouterProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

import UIKit

protocol GroupSettingRouterProtocol {

}

class GroupSettingRouter: GroupSettingRouterProtocol, RouterInjectable {
    var router: Router?

    init(router: Router) {
        self.router = router
    }

    static func createModule(router: Router) -> UIViewController {
        let view = GroupSettingViewController()
        let interactor = GroupSettingInteractor()
        let router = GroupSettingRouter(router: router)
        let presenter = GroupSettingPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }

}
