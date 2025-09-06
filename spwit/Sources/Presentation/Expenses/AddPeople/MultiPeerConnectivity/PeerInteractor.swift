
import UIKit


protocol PeerInteractorProtocol: AnyObject {
    func sendMyInfo()
}

final class PeerInteractor: PeerInteractorProtocol {
    private let multipeer = MultipeerService()
    weak var presenter: PeerPresenterProtocol?

    init() {
        multipeer.delegate = self
    }

    func sendMyInfo() {
        let me = PeerUser(name: "Syatria", email: "syatria@apple.com")
        multipeer.send(peerUser: me)
    }
}

extension PeerInteractor: MultipeerServiceDelegate {
    func didReceivePeerUser(_ user: PeerUser) {
        presenter?.didReceivePeer(user)
    }
}

