//
//  AddExpensesInteractor.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//

protocol AddExpensesInteractorProtocol : AnyObject{

    func initialFetch()
    
}


class AddExpensesInteractor: AddExpensesInteractorProtocol{
    func initialFetch() {
//        
    }
    
    weak var presenter : AddExpensesPresenter?
    
}
