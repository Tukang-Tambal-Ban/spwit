//
//   ExpensesRouter.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//
import UIKit


protocol AddPeopleRouterProtocol : AnyObject {
    func navigateBack()
    func navigateSearch()
    func navigateNextForm()
}


class AddPeopleRouter: AddPeopleRouterProtocol{
    var router: Router?

    init(router: Router) {
        self.router = router
    }

    
    static func createModule(router: Router) -> UIViewController {
        let view = AddPeopleViewController()
        let presenter = AddPeoplePresenter()
        let router = AddPeopleRouter(router: router)
        presenter.router = router
        view.presenter = presenter
       
        return view
    }
    
    
    func navigateNextForm() {
        
    }
    
    func navigateBack() {
        router?.pop()
    }
    
    
    func navigateSearch() {
        guard let sceneNavigator = router else { return }

        let searchPeopleViewController = SearchPeopleRouter.createModule(router: sceneNavigator)
        sceneNavigator.push(searchPeopleViewController)
    }
    
}
