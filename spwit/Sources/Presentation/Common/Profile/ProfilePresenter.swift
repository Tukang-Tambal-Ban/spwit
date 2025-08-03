//
//  ProfileViewProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//
import Foundation

protocol ProfilePresenterProtocol: Presentable {

}

class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewProtocol?
    private let interactor: ProfileInteractorProtocol
    private let router: ProfileRouterProtocol

    init(
        view: ProfileViewProtocol, interactor: ProfileInteractorProtocol,
        router: ProfileRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        // No-op
    }

}
