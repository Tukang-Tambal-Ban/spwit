//
//  AddMemberRouter.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 04/08/25.
//

import UIKit

protocol AddMembersRouterProtocol: AnyObject {
    func navigateBack()
    func navigateAddForm()
}

class AddMembersRouter: AddMembersRouterProtocol{

    var router: Router?
    
    init(router: Router) {
        self.router = router
    }
    
    static func createModule(router: Router) -> UIViewController {
        let view = AddMembersViewController()
        let presenter = AddMembersPresenter()
        let addMembersRouter = AddMembersRouter(router: router)
        
        view.presenter = presenter
        presenter.router = addMembersRouter
        
        return view
    }
    
    
    func navigateBack() {
        router?.pop()
    }
    
    func navigateAddForm() {
        
    }
    
}
