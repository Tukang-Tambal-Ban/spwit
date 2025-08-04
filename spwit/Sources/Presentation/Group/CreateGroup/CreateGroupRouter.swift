import UIKit

protocol CreateGroupRouterProtocol: AnyObject {
    func navigateToAddMembers(currentMembers: [User])
    func navigateToHome()
    func back()
    func dismiss()
}

final class CreateGroupRouter: CreateGroupRouterProtocol {
    private weak var viewController: UIViewController?
    var router: Router?

    static func createModule(router: Router) -> UIViewController {
        let view = CreateGroupViewController()
        let presenter = CreateGroupPresenter()
        let cgRouter = CreateGroupRouter()
        let interactor = CreateGroupInteractor(groupUsecase: DIContainer.shared.groupUsecase)

        cgRouter.router = router
        cgRouter.viewController = view

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = cgRouter

        return view
    }

    // MARK: – Navigation

    func navigateToAddMembers(currentMembers: [User]) {
        guard let navigator = router else { return }

        let addVC = SearchPeopleRouter.createModule(
            router: navigator,
            preselectedUsers: currentMembers
        ) { [weak self] selected in
            guard
                let vc = self?.viewController as? CreateGroupViewController,
                let presenter = vc.presenter as? CreateGroupPresenter
            else { return }
            
            
            print(selected.count)

            presenter.didAddUsersFromSearch(selected)
        }

        navigator.push(addVC)
    }

    func navigateToHome() {
        guard let sceneNavigator = router else { return }
        sceneNavigator.popToRootViewController(animated: true)
    }
    
    func back() { router?.pop() }
    func dismiss() { viewController?.dismiss(animated: true) }
}
