//
//  HomePagePresenter.swift
//  spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 31/07/25.
//
import UIKit

protocol HomePagePresenterProtocol: AnyObject{
    func viewDidLoad()
    func didTapAddButton()
    func didTapProfileButton()
}

class HomePagePresenter: HomePagePresenterProtocol {
    weak var view: HomePageViewProtocol?
    var interactor: HomePageInteractorProtocol?
    var router: HomePageRouterProtocol?
    
    init(
        view: HomePageViewProtocol,
        interactor: HomePageInteractorProtocol,
        router: HomePageRouterProtocol
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
