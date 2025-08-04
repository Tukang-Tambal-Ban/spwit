import UIKit

protocol CreateGroupProtocol: AnyObject {
    func updateInitialsCircle(with initials: String)
    func reloadMembers(with members: [User])
    func renderNearbyAvatars(_ users: [User])
    func showError(_ error: Error)
    func showLoading()
    func hideLoading()
}

protocol CreateGroupPresenterProtocol: AnyObject {
    func viewDidLoad()
    func createGroup()
    func didChangeGroupName(_ name: String)
    func didTapAddMembers()
    func didSelectNearbyUser(id: String)
    func didRemoveMember(id: String)
    func didAddUsersFromSearch(_ users: [User])
    func getCUrrentUser() -> User?
}

final class CreateGroupPresenter: CreateGroupPresenterProtocol {
    weak var view: CreateGroupProtocol?
    var interactor: CreateGroupInteractorProtocol?
    var router: CreateGroupRouterProtocol?

    private var groupName: String = ""
    
    var currentUser: User?
    private(set) var currentMembers: [User] = []
    
    private let nearbyUsers: [User] = [
//        User(id: "11", name: "Shafa Tiara", username: "", appleID: "", email: "", createdAt: .now),
//        User(id: "12", name: "Fariz Sidik", username: "", appleID: "", email: "", createdAt: .now),
//        User(id: "13", name: "Satria Mahatir", username: "", appleID: "", email: "", createdAt: .now),
//        User(id: "14", name: "Nada Nadu", username: "", appleID: "", email: "", createdAt: .now),
//        User(id: "15", name: "Bare Bari", username: "",  appleID: "", email: "", createdAt: .now),
//        User(id: "16", name: "Adit Raiza", username: "", appleID: "", email: "", createdAt: .now)
    ]

    // MARK: – Lifecycle

    func viewDidLoad() {
        interactor?.getCurrentUser { currentUser in
            DispatchQueue.main.async {
                self.currentUser = User(
                    id: currentUser!.id!,
                    name: currentUser!.name ?? "You",
                    username: currentUser!.username ?? "user",
                    appleID: currentUser!.appleId ?? "",
                    email: currentUser!.email ?? "email@example.com",
                    createdAt: .now
                )
                
                if currentUser != nil {
                    self.currentMembers.append(self.currentUser!)
                }
                
                self.updateUI()
            }
            
        }
    }
    
    func getCUrrentUser() -> User? {
        return currentUser
    }

    // MARK: – Input from View

    func didChangeGroupName(_ name: String) {
        groupName = name
        let initials = name.split(separator: " ")
                           .compactMap { $0.first }
                           .prefix(2)
                           .map(String.init)
                           .joined()
                           .uppercased()
        view?.updateInitialsCircle(with: initials)
    }

    func createGroup() {
        let payload = CreateGroupRequestEntity(name: groupName, memberIds: currentMembers.map(\.id))
        view?.showLoading()
        interactor?.createGroup(payload: payload) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.hideLoading()
                switch result {
                case .success(_):
                    self?.navigateToHome()
                case .failure(let error):
                    self?.view?.showError(error)
                }
            }
        }
    }
    
    func navigateToHome() {
        router?.navigateToHome()
    }

    func didTapAddMembers() {
        router?.navigateToAddMembers(currentMembers: currentMembers)
    }

    func didSelectNearbyUser(id: String) {
        guard
            !currentMembers.contains(where: { $0.id == id }),
            let user = nearbyUsers.first(where: { $0.id == id })
        else { return }

        currentMembers.append(user)
        updateUI()
    }

    func didRemoveMember(id: String) {
        currentMembers.removeAll { $0.id == id && $0.name.lowercased() != "you" }
        updateUI()
    }

    func didAddUsersFromSearch(_ users: [User]) {
        print(users.count)
        for u in users where !currentMembers.contains(where: { $0.id == u.id }) {
            currentMembers.append(u)
        }
        updateUI()
    }

    // MARK: – Private

    private func updateUI() {
        print("reload")
        print(currentUser?.name ?? "no user")
        view?.reloadMembers(with: currentMembers)
        let filtered = nearbyUsers.filter { n in !currentMembers.contains(where: { $0.id == n.id }) }
        view?.renderNearbyAvatars(filtered)
    }
}
