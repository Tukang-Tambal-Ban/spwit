//
//  AddExpansesPresenter.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//

import UIKit

protocol AddExpansesViewProtocol : AnyObject {
    func didNextTapped()
    func didBackTapped()
    func viewDidLoad()
}

class AddExpansesPresenter : AddExpansesViewProtocol {
    
    
    weak var view : AddExpansesViewProtocol?
    var router : AddExpansesRouterProtocol?
    var interactors : AddExpansesInteractorProtocol?
    
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
