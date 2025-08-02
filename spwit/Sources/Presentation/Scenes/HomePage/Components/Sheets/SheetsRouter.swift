//
//  SheetsInteractor.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 01/08/25.
//

protocol SheetsRouterProtocol: AnyObject{
    func dismiss()
    func navigateToCreateGroup()
    func navigateToCreateExpenses()
    func navigateToTakePict()
}

import UIKit
class SheetsRouter: SheetsRouterProtocol {
    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController{
        let view = SheetsViewController()
        let presenter = SheetPresenter()
        let router = SheetsRouter()
        
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
//        create
    }
    
    func navigateToTakePict() {
//        take
    }
    
    
    
}
