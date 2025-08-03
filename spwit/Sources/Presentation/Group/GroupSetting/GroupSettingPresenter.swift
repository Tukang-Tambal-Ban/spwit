//
//  SimplifyViewProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//
import Foundation

protocol SimplifyPresenterProtocol: Presentable {

}

class SimplifyPresenter: SimplifyPresenterProtocol {
    weak var view: SimplifyViewProtocol?
    private let interactor: SimplifyInteractorProtocol
    private let router: SimplifyRouterProtocol

    init(
        view: SimplifyViewProtocol, interactor: SimplifyInteractorProtocol,
        router: SimplifyRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        // No-op
    }

}
