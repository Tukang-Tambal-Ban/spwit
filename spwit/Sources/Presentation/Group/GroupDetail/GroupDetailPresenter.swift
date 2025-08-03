//
//  GroupDetailViewProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//
import Foundation

protocol GroupDetailPresenterProtocol: Presentable {

}

class GroupDetailPresenter: GroupDetailPresenterProtocol {
    weak var view: GroupDetailViewProtocol?
    private let interactor: GroupDetailInteractorProtocol
    private let router: GroupDetailRouterProtocol

    init(
        view: GroupDetailViewProtocol, interactor: GroupDetailInteractorProtocol,
        router: GroupDetailRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        // No-op
    }

}
