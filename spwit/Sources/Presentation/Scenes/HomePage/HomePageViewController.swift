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
    
    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        let image = UIImage(systemName: "person.circle.fill", withConfiguration: symbolConfig)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(red: 0.643, green: 0.941, blue: 0, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()


    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 90, weight: .regular)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(red: 0.643, green: 0.941, blue: 0, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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

            addButton.widthAnchor.constraint(equalToConstant: 90),
            addButton.heightAnchor.constraint(equalToConstant: 90),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupTapGesture() {
        profileButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
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
//            .previewDisplayName("UIKit: Sign In Screen")
    }
}
#endif
