//
//  CreateGroupPresenter.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 02/08/25.
//

import UIKit
protocol CreateGroupPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didChangeGroupName(_ name: String)
    func didTapDoneButton()
    func didTapAddPeople()
}

class CreateGroupPresenter: CreateGroupPresenterProtocol {
    weak var view : CreateGroupProtocol?
    var interactor: CreateGroupInteractorProtocol?
    var router: CreateGroupRouterProtocol?
    
    private var groupName : String = ""
    
    func didChangeGroupName(_ name: String) {
        groupName = name
        let intial = name.split(separator: " ").compactMap { $0.first }.prefix(2)
        view?.updateInitialsCircle(with: intial.map{ String($0) }.joined().uppercased())
    }
    
    func viewDidLoad() {
        view?.updateInitialsCircle(with: "")
    }
    
    func didTapDoneButton() {
        
    }
    
    func didTapAddPeople() {
        
    }
    
    
}
