//
//  PeerRouterProtocol.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 9/6/25.
//

import UIKit

protocol PeerRouterProtocol: AnyObject {}

final class PeerRouter: PeerRouterProtocol {
    static func createModule() -> UIViewController {
        let view = PeerViewController()
        let presenter = PeerPresenter()
        let interactor = PeerInteractor()
        let router = PeerRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }
}
