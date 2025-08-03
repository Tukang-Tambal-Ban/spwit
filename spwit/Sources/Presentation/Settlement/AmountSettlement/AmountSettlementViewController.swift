//
//  AmountSettlementViewController.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

import UIKit

protocol AmountSettlementViewProtocol: AnyObject {

}

class AmountSettlementViewController: UIViewController, AmountSettlementViewProtocol {
    var presenter: AmountSettlementPresenterProtocol?

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

    struct AmountSettlementViewControllerPreview: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> AmountSettlementViewController {
            return AmountSettlementViewController()
        }
        func updateUIViewController(
            _ uiViewController: AmountSettlementViewController, context: Context
        ) {}
    }

    struct AmountSettlementViewController_Previews: PreviewProvider {
        static var previews: some View {
            AmountSettlementViewControllerPreview()
                .edgesIgnoringSafeArea(.all)
                .previewDisplayName("UIKit: Sign In Screen")
        }
    }
#endif
