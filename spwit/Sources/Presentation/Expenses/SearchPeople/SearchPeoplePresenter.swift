
//
//  AddExpensesPresenter.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//

import UIKit

protocol SearchPeoplePresenterProtocol : AnyObject {
    func didNextTapped()
    func didBackTapped()
    func viewDidLoad()
}

class SearchPeoplePresenter : SearchPeoplePresenterProtocol {
    
    weak var view : SearchPeopleViewController?
    var router : SearchPeopleRouterProtocol?
    
    func didBackTapped() {
        router?.navigateBack()
    }
    
    func didNextTapped() {
        router?.navigateNextForm()
    }
    
    func viewDidLoad() {
    }
    
}
