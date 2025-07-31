protocol SignInRouterProtocol {}

class SignInRouter: SignInRouterProtocol, RouterInjectable {
    var router: Router?

    init(router: Router) {
        self.router = router
    }

    static func createModule(router: Router) -> UIViewController {
        let view = SignInViewController()
        let interactor = SignInInteractor(authUsecase: DIContainer.shared.authUsecase)
        let router = SignInRouter(router: router)
        let presenter = SignInPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}