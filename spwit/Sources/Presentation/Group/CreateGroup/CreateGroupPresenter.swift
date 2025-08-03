//
//  CreateGroupViewProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//
import Foundation

protocol CreateGroupPresenterProtocol: Presentable {
    func createGroup(with payload: CreateGroupRequestEntity)
}

class CreateGroupPresenter: CreateGroupPresenterProtocol {
    weak var view: CreateGroupViewProtocol?
    private let interactor: CreateGroupInteractorProtocol
    private let router: CreateGroupRouterProtocol

    init(
        view: CreateGroupViewProtocol, interactor: CreateGroupInteractorProtocol,
        router: CreateGroupRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        // No-op
    }
    
    func createGroup(with payload: CreateGroupRequestEntity) {
        view?.showLoading()
        interactor.createGroup(payload: payload) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.hideLoading()
                switch result {
                case .success(let entity):
                    self?.view?.showResult(from: entity)
                case .failure(let error):
                    self?.view?.showError(error: error)
                }
            }
        }
    }

}
