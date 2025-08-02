//
//  AddExpansesInteractor.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//

protocol AddExpansesInteractorProtocol : AnyObject{

    func initialFetch()
    
}


class AddExpansesInteractor: AddExpansesInteractorProtocol{
    func initialFetch() {
//        
    }
    
    weak var presenter : AddExpansesPresenter?
    
}
