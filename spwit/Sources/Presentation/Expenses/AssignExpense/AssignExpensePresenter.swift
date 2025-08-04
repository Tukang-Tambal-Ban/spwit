//
//  AssignExpenseViewProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//
import Foundation

protocol AssignExpensePresenterProtocol: Presentable {

}

class AssignExpensePresenter: AssignExpensePresenterProtocol {
    weak var view: AssignExpenseViewProtocol?
    private let interactor: AssignExpenseInteractorProtocol
    private let router: AssignExpenseRouterProtocol

    init(
        view: AssignExpenseViewProtocol, interactor: AssignExpenseInteractorProtocol,
        router: AssignExpenseRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        // No-op
    }

}
