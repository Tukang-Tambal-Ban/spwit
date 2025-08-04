//
//  HomeRouter.swift
//  spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 31/07/25.
//
import UIKit

protocol HomeRouterProtocol: AnyObject {
    func navigateToSheets()
    func navigateToProfile()
    func createNewSheetView() -> UIViewController
}

class HomeRouter: HomeRouterProtocol, RouterInjectable {
    var router: Router?
    private weak var viewController: UIViewController?

    init(router: Router, viewController: UIViewController) {
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
        return CreateNewSheetRouter.createModule(router: router)
    }

    static func createModule(router: Router) -> UIViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor(groupUsecase: DIContainer.shared.groupUsecase)
        let pageRouter = HomeRouter(router: router, viewController: view)
        let presenter = HomePresenter(
            view: view,
            interactor: interactor,
            router: pageRouter
        )
        view.presenter = presenter
        return view
    }

}
