//
//  GroupSettingViewController.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

import UIKit

protocol GroupSettingViewProtocol: AnyObject {

}

class GroupSettingViewController: UIViewController, GroupSettingViewProtocol {
    var presenter: GroupSettingPresenterProtocol?

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

    struct GroupSettingViewControllerPreview: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> GroupSettingViewController {
            return GroupSettingViewController()
        }
        func updateUIViewController(
            _ uiViewController: GroupSettingViewController, context: Context
        ) {}
    }

    struct GroupSettingViewController_Previews: PreviewProvider {
        static var previews: some View {
            GroupSettingViewControllerPreview()
                .edgesIgnoringSafeArea(.all)
                .previewDisplayName("UIKit: Sign In Screen")
        }
    }
#endif
