//
//  AddExpensesPresenter.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//

import UIKit

protocol AddExpensesPresenterProtocol : AnyObject {
    func didNextTapped()
    func didBackTapped()
    func viewDidLoad()
}

class AddExpensesPresenter : AddExpensesPresenterProtocol {
    
    weak var view : AddExpensesViewControllerProtocol?
    var router : AddExpensesRouterProtocol?
    var interactors : AddExpensesInteractorProtocol?
    
    func didBackTapped() {
        router?.navigateBack()
    }
    
    func didNextTapped() {
        router?.navigateNextForm()
    }
    
    func viewDidLoad() {
        interactors?.initialFetch()
    }
    
}
