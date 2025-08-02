//
//  SignInViewProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//
import Foundation

protocol SignInPresenterProtocol: Presentable {
    func signIn(with payload: SignInRequestEntity)
    func navigateToHome(signInEntity: SignInEntity)
}

class SignInPresenter: SignInPresenterProtocol {
    weak var view: SignInViewProtocol?
    private let interactor: SignInInteractorProtocol
    private let router: SignInRouterProtocol

    init(view: SignInViewProtocol, interactor: SignInInteractorProtocol, router: SignInRouterProtocol) {
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
                    self?.view?.showResult(from: entity)
                case .failure(let error):
                    self?.view?.showError(error)
                }
            }
        }
    }
    
    func navigateToHome(signInEntity: SignInEntity) {
        router.navigateToHomePage(signInEntity)
    }
}
