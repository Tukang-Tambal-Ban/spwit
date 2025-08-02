//
//  ExpansesRouter.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//
import UIKit


protocol AddExpansesRouterProtocol : AnyObject {
    
    func navigateBack(from view : UIViewController)
    func navigateNextForm(from view : UIViewController)
    
    
}


class AddExpansesRouter: AddExpansesRouterProtocol{
    var router: Router?

    init(router: Router) {
        self.router = router
    }

    
    static func createModule(router: Router) -> UIViewController {
        let view = AddExpansesViewController()
        let presenter = AddExpansesPresenter()
        let router = AddExpansesRouter(router: router)
//        let interactor = AddExpansesInteractor()
        
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
