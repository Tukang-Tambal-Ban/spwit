import Foundation


protocol SearchPeopleViewProtocol: AnyObject {
    func showSuggestedUsers(_ users: [User])
    func showSelectedUsers(_ users: [User])
    func showSearchUsers(_ users: [User])
    func showError(_ error: Error)
    func showLoading()
    func hideLoading()
}

protocol SearchPeoplePresenterProtocol: AnyObject {
    func fetchSuggestedUsers()
    func searchUsers(query: String)
    func toggleSelectedUser(with user: User)
    func didBackTapped()
    func didAddTapped()
    func isExpanded() -> Bool
    func toggleExpanded()
}

final class SearchPeoplePresenter: SearchPeoplePresenterProtocol {
    weak var view: SearchPeopleViewProtocol?
    var router: SearchPeopleRouterProtocol?
    var interactor: SearchPeopleInteractorProtocol?

    private let onUsersSelected: ([User]) -> Void
    var suggestedUsers: [User] = []
    var searchedUsers: [User] = []
    var selectedUsers: [User] = []
    var _isExpanded = true

    init(preselected: [User], onSelected: @escaping ([User]) -> Void) {
        onUsersSelected = onSelected
        selectedUsers = preselected
        reload()
    }
    
    func reload() {
        self.view?.showSuggestedUsers(suggestedUsers)
        self.view?.showSelectedUsers(selectedUsers)
        self.view?.showSearchUsers(searchedUsers)
        
        onUsersSelected(selectedUsers)
    }

    // MARK: – Selection helpers
    func toggleSelectedUser(with user: User) {
        if selectedUsers.contains(where: { $0.id == user.id }) {
            selectedUsers.removeAll { $0.id == user.id }
        } else {
            selectedUsers.append(user)
        }
        reload()
    }
    
    // MARK: – Nav
    func didBackTapped() { router?.navigateBack() }
    func didAddTapped() {
        router?.navigateToAddPeople(selected: selectedUsers)
    }
    
    func fetchSuggestedUsers() {
        view?.showLoading()
        interactor?.fetchSuggestedUsers { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.hideLoading()
                switch result {
                case .success(let entity):
                    self?.suggestedUsers = entity
                    self?.reload()
                case .failure(let error):
                    self?.view?.showError(error)
                }
            }
        }
    }
    
    func searchUsers(query: String) {
        view?.showLoading()
        interactor?.searchUsers(username: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.hideLoading()
                switch result {
                case .success(let entity):
                    self?.searchedUsers = entity
                    self?.reload()
                case .failure(let error):
                    self?.view?.showError(error)
                }
            }
        }
    }
    
    func isExpanded() -> Bool {
        return _isExpanded
    }
    
    func toggleExpanded() {
        _isExpanded.toggle()
    }
    
}
