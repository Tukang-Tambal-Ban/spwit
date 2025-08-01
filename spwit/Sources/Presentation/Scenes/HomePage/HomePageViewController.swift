//
//  HomePageViewController.swift
//  spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 31/07/25.
//

import UIKit

protocol HomePageViewProtocol: AnyObject{
    func showWelcomeMessages()
}

class HomePageViewController: UIViewController, HomePageViewProtocol {
    func showWelcomeMessages() {
//        test
    }
    
    var presenter: HomePagePresenterProtocol?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Start Splitting Your Expense"
        label.textColor = UIColor(red: 0.643, green: 0.941, blue: 0, alpha: 1)
        label.frame = CGRect(x: 0, y: 0, width: 220, height: 21)
        label.font = UIFont(name: "SFPro-Bold", size: 16)
        label.textAlignment = .center
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap the plus button to get started."
        label.textColor = UIColor(red: 0.643, green: 0.941, blue: 0, alpha: 0.5)
        label.frame = CGRect(x: 0, y: 0, width: 220, height: 18)
        label.font = UIFont(name: "SFPro-Regular", size: 13)
        label.textAlignment = .center
        return label
    }()
//    private let profileButton: UILabel = {
//        let label = UILabel()
//        let symbol = UIImage.SymbolConfiguration(pointSize: 13, weight: .regular)
//        if let image = UIImage(systemName: "person.fill", withConfiguration: symbol){
//            let attachment = NSTextAttachment()
//            attachment.image = image
//            attachment.bounds = CGRect(x: 0, y: -2, width: 13, height: 13)
//            let attributedString = NSMutableAttributedString(attachment: attachment)
//            label.attributedText = attributedString
//        } else {
//            label.text = ""
//        }
//        label.textColor = UIColor(red: 0.643, green: 0.941, blue: 0, alpha: 1)
//        label.frame = CGRect(x: 0, y: 0, width: 43, height: 35)
//        label.font = UIFont(name: "SFPro-Regular", size: 36)
//        label.textAlignment = .center
//        return label
//    }()
    private let profileButton: UIImageView = {
        let imageView = UIImageView()
        
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        if let image = UIImage(systemName: "person.circle.fill", withConfiguration: symbolConfig) {
            imageView.image = image.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = UIColor(red: 0.643, green: 0.941, blue: 0, alpha: 1)
        }

        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return imageView
    }()
    private let addButton: UIImageView = {
        let imageView = UIImageView()
        
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 84, weight: .regular)
        if let image = UIImage(systemName: "plus.circle.fill", withConfiguration: symbolConfig) {
            imageView.image = image.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = UIColor(red: 0.643, green: 0.941, blue: 0, alpha: 1)
        }

        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.059, green: 0.129, blue: 0.235, alpha: 1)
        presenter?.viewDidLoad()
        setupLayout()
        setupTapGesture()
    }
    private func setupLayout() {
        [titleLabel, subtitleLabel, profileButton, addButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            profileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            addButton.widthAnchor.constraint(equalToConstant: 84),
            addButton.heightAnchor.constraint(equalToConstant: 73),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
    private func setupTapGesture() {
        let tapPlus = UITapGestureRecognizer(target: self, action: #selector(addTapped))
        addButton.isUserInteractionEnabled = true
        addButton.addGestureRecognizer(tapPlus)
        
        let tapProfile = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        profileButton.isUserInteractionEnabled = true
        profileButton.addGestureRecognizer(tapProfile)
    }
    @objc func addTapped() {
        presenter?.didTapAddButton()
    }
    @objc func profileTapped() {
        presenter?.didTapProfileButton()
    }
}


#if DEBUG
import SwiftUI

struct HomePageViewPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HomePageViewController {
        return HomePageViewController()
    }
    func updateUIViewController(_ uiViewController: HomePageViewController, context: Context) {}
}

struct HomePageViewViewController_Preview: PreviewProvider {
    static var previews: some View {
        HomePageViewPreview()
            .edgesIgnoringSafeArea(.all)
            .previewDisplayName("UIKit: Sign In Screen")
    }
}
#endif

//
//#if DEBUG
//import SwiftUI
//
//struct HomePageViewControllerPreview: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> HomePageViewController {
//        let vc = HomePageViewController()
//        // Optionally, inject a mock presenter if needed for testing
//        return vc
//    }
//    func updateUIViewController(_ uiViewController: HomePageViewController, context: Context) {}
//}
//
//struct HomePageViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        HomePageViewControllerPreview()
//            .edgesIgnoringSafeArea(.all)
//            .previewDisplayName("UIKit: Home Page")
//    }
//}
//#endif
//
