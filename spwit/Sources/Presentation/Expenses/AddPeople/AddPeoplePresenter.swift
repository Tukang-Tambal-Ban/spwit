
//
//  AddExpensesPresenter.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//

import UIKit

protocol AddPeoplePresenterProtocol : AnyObject {
    func didNextTapped()
    func didBackTapped()
    func navigateSearch()
    func viewDidLoad()
}

class AddPeoplePresenter : AddPeoplePresenterProtocol {
    
    weak var view : AddPeopleViewProtocol?
    var router : AddPeopleRouterProtocol?
    
    func didBackTapped() {
        router?.navigateBack()
    }
    
    func didNextTapped() {
        router?.navigateNextForm()
    }
    
    func navigateSearch() {
        print("hererererer")
        router?.navigateSearch()
    }
    
    func viewDidLoad() {
        
    }
    
}
