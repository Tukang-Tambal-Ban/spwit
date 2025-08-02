//
//   ExpensesRouter.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//
import UIKit


protocol AddExpensesRouterProtocol : AnyObject {
    
    func navigateBack(from view : UIViewController)
    func navigateNextForm(from view : UIViewController)
    
    
}


class AddExpensesRouter: AddExpensesRouterProtocol{
    var router: Router?

    init(router: Router) {
        self.router = router
    }

    
    static func createModule(router: Router) -> UIViewController {
        let view = AddExpensesViewController()
        let presenter = AddExpensesPresenter()
        let router = AddExpensesRouter(router: router)
//        let interactor = AddExpensesInteractor()
        
        view.presenter = presenter
        presenter.router = router
       
    
        return view
    }
    
    
    func navigateNextForm(from view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
    
    weak var navigationController : UINavigationController?
    func navigateBack(from view: UIViewController) {
        navigationController?.popViewController(animated: true)
    }
    

    
   
    
}
