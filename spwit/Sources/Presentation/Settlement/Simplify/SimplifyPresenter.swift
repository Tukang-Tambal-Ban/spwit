//
//  GroupSettingViewProtocol.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//
import Foundation

protocol GroupSettingPresenterProtocol: Presentable {

}

class GroupSettingPresenter: GroupSettingPresenterProtocol {
    weak var view: GroupSettingViewProtocol?
    private let interactor: GroupSettingInteractorProtocol
    private let router: GroupSettingRouterProtocol

    init(
        view: GroupSettingViewProtocol, interactor: GroupSettingInteractorProtocol,
        router: GroupSettingRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        // No-op
    }

}
