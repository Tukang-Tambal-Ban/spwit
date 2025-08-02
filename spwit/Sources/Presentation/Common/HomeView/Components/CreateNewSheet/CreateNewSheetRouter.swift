//
//  SheetsInteractor.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 01/08/25.
//

import UIKit

protocol CreateNewSheetRouterProtocol: AnyObject {
    func dismiss()
    func navigateToCreateGroup()
    func navigateToCreateExpenses()
    func navigateToTakePict()
}

class CreateNewSheetRouter: CreateNewSheetRouterProtocol {
    var router: Router?
    weak var viewController: UIViewController?

    init(router: Router?) {
        self.router = router
    }

    static func createModule(router: Router?) -> UIViewController {
        let view = CreateNewSheetViewController()
        let presenter = CreateNewSheetPresenter()
        let router = CreateNewSheetRouter(router: router)

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        router.viewController = view

        return view
    }

    func dismiss() {
        viewController?.dismiss(animated: true)
    }

    func navigateToCreateGroup() {
        //        create
    }

    func navigateToCreateExpenses() {
        dismiss()
        
        guard let sceneNavigator = router else { return }

        let addExpensesViewController = AddExpensesRouter.createModule(router: sceneNavigator)
        sceneNavigator.push(addExpensesViewController)
        
    }

    func navigateToTakePict() {
        //        take
    }

}
