import UIKit

protocol SearchPeopleRouterProtocol: AnyObject {
    func navigateBack()
    func navigateToAddPeople(selected: [User])
}

final class SearchPeopleRouter: SearchPeopleRouterProtocol {
    var router: Router?
    private let onUsersSelected: ([User]) -> Void

    init(router: Router, onUsersSelected: @escaping ([User]) -> Void) {
        self.router = router
        self.onUsersSelected = onUsersSelected
    }

    static func createModule(
        router: Router,
        preselectedUsers: [User],
        onUsersSelected: @escaping ([User]) -> Void
    ) -> UIViewController {
        let view = SearchPeopleViewController()
        let interactor = SearchPeopleInteractor(userUsecase: DIContainer.shared.userUsecase)
        let presenter = SearchPeoplePresenter(
            preselected: preselectedUsers,
            onSelected: onUsersSelected
        )
        let spRouter = SearchPeopleRouter(
            router: router, onUsersSelected: onUsersSelected
        )

        presenter.router = spRouter
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        return view
    }

    func navigateBack() { router?.pop() }
    func navigateToAddPeople(selected: [User]) {
        print("lolll")
        print(selected.count)
        onUsersSelected(selected)
        router?.pop()
    }
}
