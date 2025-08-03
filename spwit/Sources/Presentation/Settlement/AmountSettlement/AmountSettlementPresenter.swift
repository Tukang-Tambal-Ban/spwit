//
//  AmountSettlementViewProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//
import Foundation

protocol AmountSettlementPresenterProtocol: Presentable {

}

class AmountSettlementPresenter: AmountSettlementPresenterProtocol {
    weak var view: AmountSettlementViewProtocol?
    private let interactor: AmountSettlementInteractorProtocol
    private let router: AmountSettlementRouterProtocol

    init(
        view: AmountSettlementViewProtocol, interactor: AmountSettlementInteractorProtocol,
        router: AmountSettlementRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        // No-op
    }

}
