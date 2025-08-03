//
//  CreateGroupRouter.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 02/08/25.
//

import UIKit

protocol CreateGroupRouterProtocol: AnyObject {
    func navigateToAddPeople()
    func navigateToGroupDetail()
    func back()
    func dismiss()

}

class CreateGroupRouter: CreateGroupRouterProtocol {
    var router: Router?

    init(router: Router) {
        self.router = router
    }

    private weak var viewController: UIViewController?
    
    static func createModule(router: Router) -> UIViewController{
        let view = CreateGroupViewController()
        let presenter = CreateGroupPresenter()
        let router = CreateGroupRouter(router: router)
        let interactor = CreateGroupInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.viewController = view
        
        return view
    }
    
    func navigateToAddPeople() {
//        this is code to nav add people
        print("Nav to add people")
    }
    
    func navigateToGroupDetail() {
//        this is code to group detail
    }
    func back() {
//        to back
    }
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
