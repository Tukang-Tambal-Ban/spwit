//
//  HomePresenter.swift
//  spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 31/07/25.
//
import UIKit


protocol HomeViewProtocol: AnyObject {
    func showWelcomeMessages()
    func showGroupList()
    func hideWelcomeMessages()
    func showResult(from entity: GroupsEntity)
    func showError(_ error: Error)
    func showLoading()
    func hideLoading()
}

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapAddButton()
    func didTapProfileButton()
    func fetchGroups()
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
        
    }
    
    func fetchGroups() {
        view?.showLoading()
        interactor?.fetchGroups { [weak self] result in
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
