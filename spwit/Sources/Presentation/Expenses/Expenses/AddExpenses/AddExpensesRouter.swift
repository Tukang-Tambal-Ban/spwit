//
//   ExpensesRouter.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//
import UIKit


protocol AddExpensesRouterProtocol : AnyObject {
    func navigateBack()
    func navigateNextForm()
}


class AddExpensesRouter: AddExpensesRouterProtocol{
    var router: Router?

    init(router: Router) {
        self.router = router
    }

    
    static func createModule(router: Router) -> UIViewController {
        let view = AddExpensesViewController()
        let router = AddExpensesRouter(router: router)
        let presenter = AddExpensesPresenter()
        presenter.router = router
        view.presenter = presenter
    
        return view
    }
    
    func navigateNextForm() {
        guard let sceneNavigator = router else { return }

        let addPeopleViewController = AddPeopleRouter.createModule(router: sceneNavigator)
        sceneNavigator.push(addPeopleViewController)
    }
    
    func navigateBack() {
        router?.pop()
    }
   
    
}
