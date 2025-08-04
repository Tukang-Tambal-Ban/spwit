//
//  SignInViewProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//
import Foundation

protocol SignInViewProtocol: AnyObject {
    func showError(_ error: Error)
    func showLoading()
    func hideLoading()
}

protocol SignInPresenterProtocol: Presentable {
    func signIn(with payload: SignInRequestEntity)
    func navigateToHome()
}

class SignInPresenter: SignInPresenterProtocol {
    weak var view: SignInViewProtocol?
    private let interactor: SignInInteractorProtocol
    private let router: SignInRouterProtocol

    init(
        view: SignInViewProtocol, interactor: SignInInteractorProtocol, router: SignInRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        // No-op
    }

    func signIn(with payload: SignInRequestEntity) {
        view?.showLoading()
        interactor.signIn(payload: payload) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.hideLoading()
                switch result {
                case .success(let entity):
                    self?.navigateToHome()
                case .failure(let error):
                    self?.view?.showError(error)
                }
            }
        }
    }

    func navigateToHome() {
        router.navigateToHomeView()
    }
}
