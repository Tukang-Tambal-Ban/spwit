//
//  AddMemberPresenter.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 04/08/25.
//

import UIKit

protocol AddMembersPresenterProtocol : AnyObject {
    func didAddTapped()
    func didBackTapped()
    func navigateSearch()
    func viewDidLoad()
}

class AddMembersPresenter : AddMembersPresenterProtocol {
    
    weak var view : AddMembersViewController?
    var router : AddMembersRouterProtocol?
    
    func didBackTapped() {
        router?.navigateBack()
    }
    
    func didAddTapped() {
        router?.navigateAddForm()
    }
    
    func navigateSearch() {
//        router?.navigateSearch()
    }
    
    func viewDidLoad() {
        
    }
    
}

