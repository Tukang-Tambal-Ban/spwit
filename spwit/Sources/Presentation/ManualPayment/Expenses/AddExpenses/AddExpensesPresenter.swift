//
//  AddExpensesPresenter.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//

import UIKit

protocol AddExpensesViewProtocol : AnyObject {
    func didNextTapped()
    func didBackTapped()
    func viewDidLoad()
}

class AddExpensesPresenter : AddExpensesViewProtocol {
    
    
    weak var view : AddExpensesViewProtocol?
    var router : AddExpensesRouterProtocol?
    var interactors : AddExpensesInteractorProtocol?
    
    func didBackTapped() {
        if let vc = view as? UIViewController {
            router?.navigateBack(from: vc)
        }
    }
    
    func didNextTapped() {
        if let vc = view as? UIViewController {
            router?.navigateNextForm(from: vc)
        }
    }
    
    func viewDidLoad() {
        interactors?.initialFetch()
    }
    
}
