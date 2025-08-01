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

class HomePageRouter: HomePageRouterProtocol {
    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let view = HomePageViewController()
        let presenter = HomePagePresenter()
        let interactor = HomePageInteractor()
        let router = HomePageRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = view
        
        return view
    }
    func navigateToCreateExpenses() {
//        test
    }
    
    func navigateToProfile() {
//        test
    }
    
    
}
