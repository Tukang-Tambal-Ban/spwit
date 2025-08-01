//
//  HomePageRouter.swift
//  spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 31/07/25.
//
import UIKit

protocol HomePageRouterProtocol: AnyObject {
    func navigateToCreateExpenses()
    func navigateToProfile()
}

class HomePageRouter: HomePageRouterProtocol, RouterInjectable {
    var router: Router?
    private weak var viewController: UIViewController?
    
    init(router : Router, viewController: UIViewController) {
        self.router = router
        self.viewController = viewController
    }
    
    static func createModule(router: Router, for signIn : SignInEntity) -> UIViewController {
        let view = HomePageViewController()
        let interactor = HomePageInteractor()
        let router = HomePageRouter(router: router, viewController: view)
        let presenter = HomePagePresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
        view.presenter = presenter
        
        return view
    }
    func navigateToCreateExpenses() {
//        test
    }
    
    func navigateToProfile() {
//        test
    }
    
    
}
