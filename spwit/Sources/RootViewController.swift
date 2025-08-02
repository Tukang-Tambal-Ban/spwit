//
//  ViewController.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 28/07/25.
//
import UIKit

class RootViewController: UIViewController, RouterInjectable {
    var router: Router?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(router: Router? = nil) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toInitialPage()
    }
    
    private func toInitialPage() {
        guard let sceneNavigator = router else { return }
        
//        let signInViewController = AddExpansesRouter.createModule(router: sceneNavigator)
        let signInViewController = AddExpansesRouter.createModule(router: sceneNavigator)
        sceneNavigator.setRootViewController(signInViewController)
    }
    
}

