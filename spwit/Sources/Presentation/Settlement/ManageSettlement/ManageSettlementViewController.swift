//
//  ManageSettlementViewController.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

import UIKit

protocol ManageSettlementViewProtocol: AnyObject {

}

class ManageSettlementViewController: UIViewController, ManageSettlementViewProtocol {
    var presenter: ManageSettlementPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {

        view.backgroundColor = .darkBlue

        NSLayoutConstraint.activate([

            ])
    }

}

#if DEBUG
    import SwiftUI

    struct ManageSettlementViewControllerPreview: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> ManageSettlementViewController {
            return ManageSettlementViewController()
        }
        func updateUIViewController(
            _ uiViewController: ManageSettlementViewController, context: Context
        ) {}
    }

    struct ManageSettlementViewController_Previews: PreviewProvider {
        static var previews: some View {
            ManageSettlementViewControllerPreview()
                .edgesIgnoringSafeArea(.all)
                .previewDisplayName("UIKit: Sign In Screen")
        }
    }
#endif
