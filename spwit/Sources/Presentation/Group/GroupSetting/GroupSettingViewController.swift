//
//  SimplifyViewController.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

import UIKit

protocol SimplifyViewProtocol: AnyObject {

}

class SimplifyViewController: UIViewController, SimplifyViewProtocol {
    var presenter: SimplifyPresenterProtocol?

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

    struct SimplifyViewControllerPreview: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> SimplifyViewController {
            return SimplifyViewController()
        }
        func updateUIViewController(
            _ uiViewController: SimplifyViewController, context: Context
        ) {}
    }

    struct SimplifyViewController_Previews: PreviewProvider {
        static var previews: some View {
            SimplifyViewControllerPreview()
                .edgesIgnoringSafeArea(.all)
                .previewDisplayName("UIKit: Sign In Screen")
        }
    }
#endif
