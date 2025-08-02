//
//  HomePageRouter.swift
//  spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 31/07/25.
//
import UIKit

protocol HomePageRouterProtocol: AnyObject {
    func navigateToSheets()
    func navigateToProfile()
    func createNewSheetView() -> UIViewController
}

class HomePageRouter: HomePageRouterProtocol, RouterInjectable {
    var router: Router?
    private weak var viewController: UIViewController?
    
    init(router : Router, viewController: UIViewController) {
        self.router = router
        self.viewController = viewController
    }
    
    func navigateToSheets() {
        let sheetVC = createNewSheetView()
        sheetVC.modalPresentationStyle = .pageSheet
        viewController?.present(sheetVC, animated: true)
    }
    
    func navigateToProfile() {
        print("Nav to profile")
    }
    
    func createNewSheetView() -> UIViewController {
        return SheetsRouter.assembleModule()
    }
    
    static func createModule(router: Router, for signIn : SignInEntity) -> UIViewController {
        let view = HomePageViewController()
        let interactor = HomePageInteractor()
        let pageRouter = HomePageRouter(router: router, viewController: view)
        let presenter = HomePagePresenter(
                view: view,
                interactor: interactor,
                router: pageRouter
            )
        view.presenter = presenter
        return view
    }
        
//        func assembleModule() -> UIViewController {
//            let view = HomePageViewController()
//            let interactor = HomePageInteractor()
//            let router = HomePageRouter(router: router, viewController: view)
//            let presenter = HomePagePresenter(
//                view: view,
//                interactor: interactor,
//                router: router
//            )
//            
//            view.presenter = presenter
//            
//            return view
//        }
        
        
}
