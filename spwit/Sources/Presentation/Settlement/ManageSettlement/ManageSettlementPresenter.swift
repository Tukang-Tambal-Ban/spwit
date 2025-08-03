//
//  ManageSettlementViewProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//
import Foundation

protocol ManageSettlementPresenterProtocol: Presentable {

}

class ManageSettlementPresenter: ManageSettlementPresenterProtocol {
    weak var view: ManageSettlementViewProtocol?
    private let interactor: ManageSettlementInteractorProtocol
    private let router: ManageSettlementRouterProtocol

    init(
        view: ManageSettlementViewProtocol, interactor: ManageSettlementInteractorProtocol,
        router: ManageSettlementRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        // No-op
    }

}
