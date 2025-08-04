//
//  CreateGroupRouter.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 02/08/25.
//

import UIKit

protocol CreateGroupRouterProtocol: AnyObject {
    func navigateToAddMembers()
    func navigateToGroupDetail()
    func back()
    func dismiss()

}

class CreateGroupRouter: CreateGroupRouterProtocol {
    var router: Router?
    private weak var viewController: UIViewController?
    
    static func createModule(router: Router) -> UIViewController{
        let view = CreateGroupViewController()
        let presenter = CreateGroupPresenter()
        let createGroupRouter = CreateGroupRouter()
        let interactor = CreateGroupInteractor()
        
        createGroupRouter.router = router
        createGroupRouter.viewController = view
        
        // Set router in view controller
//        view.router = router
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = createGroupRouter
        presenter.interactor = interactor
        
        return view
    }
    
    func navigateToAddMembers() {
        guard let sceneNavigator = router else { return }
        
        let addMembersVC = AddMembersRouter.createModule(router: sceneNavigator)
        sceneNavigator.push(addMembersVC)
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
