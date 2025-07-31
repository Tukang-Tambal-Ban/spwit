//
//  SignInViewProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//
import Foundation

protocol SignInViewProtocol: AnyObject {
    func showResult(from entity: SignInEntity)
    func showError(_ error: Error)
    func showLoading()
    func hideLoading()
}

protocol SignInPresenterProtocol: Presentable {
    func signInTapped()
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

    func signInTapped() {
        view?.showLoading()
        interactor.signIn { [weak self] result in
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
}
