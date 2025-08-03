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
    func didSelectNearbyUser(name: String)
    func didRemoveMember(name: String)
}

class CreateGroupPresenter: CreateGroupPresenterProtocol {

    weak var view : CreateGroupProtocol?
    var interactor: CreateGroupInteractorProtocol?
    var router: CreateGroupRouterProtocol?
    var currentMembers: [String] = ["You"]
    var allNearbyUsers: [String] = ["Shafa Tiara", "Fariz Sidik", "Satria Mahatir", "Nada Nadu", "Bare Bari", "Adit Raiza"]

    
    private var groupName : String = ""
    
    private func filteredNearbyUsers() -> [String] {
        return allNearbyUsers.filter { !currentMembers.contains($0) }
    }

    func didChangeGroupName(_ name: String) {
        groupName = name
        let intial = name.split(separator: " ").compactMap { $0.first }.prefix(2)
        view?.updateInitialsCircle(with: intial.map{ String($0) }.joined().uppercased())
    }
    
    func viewDidLoad() {
        view?.updateInitialsCircle(with: "")
        view?.reloadMembers(with: currentMembers)
        view?.renderNearbyAvatars(filteredNearbyUsers())
    }
    
    func didTapDoneButton() {
        
    }
    
    func didTapAddPeople() {
        
    }
    
    func didSelectNearbyUser(name: String) {
        guard !currentMembers.contains(name) else { return }
        currentMembers.append(name)
        view?.reloadMembers(with: currentMembers)
        view?.renderNearbyAvatars(filteredNearbyUsers())
    }
    
    func didRemoveMember(name: String) {
        guard name.lowercased() != "you" else { return }
        currentMembers.removeAll { $0 == name }
        view?.reloadMembers(with: currentMembers)
        view?.renderNearbyAvatars(filteredNearbyUsers())
    }
    
}
