//
//  CreateGroupViewController.swift
//  spwit
//
//  Created by Adithya Firmansyah Putra on 01/08/25.
//

import UIKit

protocol CreateGroupViewProtocol: AnyObject {
    func hideLoading()
    func showLoading()
    func showResult(from result: CreateGroupEntity)
    func showError(error: Error)
}

class CreateGroupViewController: UIViewController, CreateGroupViewProtocol {

    var presenter: CreateGroupPresenterProtocol?

    private let createButton = UIButton(type: .system)
    private let groupNameTextField = UITextField()
    private let statusLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .darkBlue

        groupNameTextField.placeholder = "Enter group name"
        groupNameTextField.borderStyle = .roundedRect
        groupNameTextField.translatesAutoresizingMaskIntoConstraints = false

        createButton.setTitle("Create Group", for: .normal)
        createButton.setTitleColor(.white, for: .normal)
        createButton.backgroundColor = .systemGreen
        createButton.layer.cornerRadius = 8
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.addTarget(self, action: #selector(createGroupTapped), for: .touchUpInside)

        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        statusLabel.textColor = .white
        statusLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(groupNameTextField)
        view.addSubview(createButton)
        view.addSubview(statusLabel)

        NSLayoutConstraint.activate([
            groupNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            groupNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            groupNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            groupNameTextField.heightAnchor.constraint(equalToConstant: 44),

            createButton.topAnchor.constraint(equalTo: groupNameTextField.bottomAnchor, constant: 20),
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.widthAnchor.constraint(equalToConstant: 200),
            createButton.heightAnchor.constraint(equalToConstant: 50),

            statusLabel.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: 30),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    @objc private func createGroupTapped() {
        guard let name = groupNameTextField.text, !name.isEmpty else {
            showError(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Group name is required"]))
            return
        }

        // Dummy memberIds, replace with real data from your selected members
        let memberIds = ["e307078b-d4b0-4e48-9a3d-53561b60a3c7"]
        let request = CreateGroupRequestEntity(name: name, memberIds: memberIds)
        presenter?.createGroup(with: request)
    }

    func showLoading() {
        statusLabel.text = "Creating group..."
        statusLabel.textColor = .white
    }

    func hideLoading() {
        // No-op or reset UI if needed
    }

    func showResult(from result: CreateGroupEntity) {
        statusLabel.text = "Success: \(result.groupId)"
        statusLabel.textColor = .green
    }

    func showError(error: Error) {
        statusLabel.text = "Error: \(error.localizedDescription)"
        statusLabel.textColor = .red
    }
}

#if DEBUG
    import SwiftUI

    struct CreateGroupViewControllerPreview: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> CreateGroupViewController {
            return CreateGroupViewController()
        }
        func updateUIViewController(_ uiViewController: CreateGroupViewController, context: Context)
        {}
    }

    struct CreateGroupViewController_Previews: PreviewProvider {
        static var previews: some View {
            CreateGroupViewControllerPreview()
                .edgesIgnoringSafeArea(.all)
                .previewDisplayName("UIKit: Sign In Screen")
        }
    }
#endif
