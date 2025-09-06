//
//  PeerPresenterProtocol.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 9/6/25.
//

import UIKit

protocol PeerPresenterProtocol: AnyObject {
    func didTapSend()
    func didReceivePeer(_ user: PeerUser)
}

final class PeerPresenter: PeerPresenterProtocol {
    weak var view: PeerViewProtocol?
    var interactor: PeerInteractorProtocol?
    var router: PeerRouterProtocol?

    func didTapSend() {
        interactor?.sendMyInfo()
    }

    func didReceivePeer(_ user: PeerUser) {
        view?.showReceivedPeer(user)
    }
}
