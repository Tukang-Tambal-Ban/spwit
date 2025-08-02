//
//  HomePresenter.swift
//  spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 31/07/25.
//
import UIKit

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapAddButton()
    func didTapProfileButton()
}

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?

    init(
        view: HomeViewProtocol,
        interactor: HomeInteractorProtocol,
        router: HomeRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        interactor?.fetchInitialState()
    }

    func didTapAddButton() {
        //        router?.navigateToSheets()
        if let vc = router?.createNewSheetView() {
            vc.modalPresentationStyle = .pageSheet
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.medium()]
            }
            (view as? UIViewController)?.present(vc, animated: true)
        }
    }

    func didTapProfileButton() {
        router?.navigateToProfile()
    }

}
