//
//  ProfileViewController.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

import UIKit

protocol ProfileViewProtocol: AnyObject {

}

class ProfileViewController: UIViewController, ProfileViewProtocol {
    var presenter: ProfilePresenterProtocol?

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

    struct ProfileViewControllerPreview: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> ProfileViewController {
            return ProfileViewController()
        }
        func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) {}
    }

    struct ProfileViewController_Previews: PreviewProvider {
        static var previews: some View {
            ProfileViewControllerPreview()
                .edgesIgnoringSafeArea(.all)
                .previewDisplayName("UIKit: Sign In Screen")
        }
    }
#endif
