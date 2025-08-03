//
//  GroupDetailViewController.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

import UIKit

protocol GroupDetailViewProtocol: AnyObject {

}

class GroupDetailViewController: UIViewController, GroupDetailViewProtocol {
    var presenter: GroupDetailPresenterProtocol?

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

    struct GroupDetailViewControllerPreview: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> GroupDetailViewController {
            return GroupDetailViewController()
        }
        func updateUIViewController(_ uiViewController: GroupDetailViewController, context: Context)
        {}
    }

    struct GroupDetailViewController_Previews: PreviewProvider {
        static var previews: some View {
            GroupDetailViewControllerPreview()
                .edgesIgnoringSafeArea(.all)
                .previewDisplayName("UIKit: Sign In Screen")
        }
    }
#endif
