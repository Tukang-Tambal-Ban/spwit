//
//   ExpensesRouter.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//
import UIKit


protocol SearchPeopleRouterProtocol : AnyObject {
    func navigateBack()
    func navigateNextForm()
}


class SearchPeopleRouter: SearchPeopleRouterProtocol{
    var router: Router?

    init(router: Router) {
        self.router = router
    }

    
    static func createModule(router: Router) -> UIViewController {
        let view = SearchPeopleViewController()
        let presenter = SearchPeoplePresenter()
        let router = SearchPeopleRouter(router: router)
        presenter.router = router
        view.presenter = presenter
       
        return view
    }
    
    
    func navigateNextForm() {
        
    }
    
    func navigateBack() {
        router?.pop()
    }

}
