//
//  CreateGroupViewController.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 02/08/25.
//

import UIKit

protocol CreateGroupProtocol: AnyObject {
    func updateInitialsCircle(with initials: String)
    func reloadMembers()
}

class CreateGroupViewController: UIViewController, CreateGroupProtocol {
    
    var presenter: CreateGroupPresenterProtocol?
    
    private let initialCircle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.applyStyle(Fonts.title1.bold, color: .darkBlue)
        label.backgroundColor = .lightGreen
        label.layer.cornerRadius = 60
        label.clipsToBounds = true
        return label
    }()
    
    private let groupNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Your group name"
        label.applyStyle(Fonts.footnote.medium, color: .lightGreen)
        label.frame = CGRect(x: 0, y: 0, width: 108, height: 25)
        label.textAlignment = .left
        return label
    }()
    
    private let groupNameField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "What is this group called?"
        tf.textColor = .grey
        tf.font = Fonts.callout.regular
        tf.borderStyle = .none
        tf.addTarget(nil, action: #selector(groupNameChanged), for: .editingChanged)
        return tf
    }()
    
    private let underline: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGreen
        return view
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = Fonts.callout.bold
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .grey
        button.layer.cornerRadius = 24
        return button
    }()
    
    private let memberLabel: UILabel = {
        let label = UILabel()
        label.text = "Member"
        label.applyStyle(Fonts.callout.medium, color: .lightGreen)
        label.frame = CGRect(x: 0, y: 0, width: 108, height: 25)
        label.textAlignment = .left
        return label
    }()
    
    private let addPeopleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Member"
        label.applyStyle(Fonts.callout.medium, color: .lightGreen)
        label.frame = CGRect(x: 0, y: 0, width: 108, height: 25)
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBlue
        presenter?.viewDidLoad()
        setUpLayout()
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
    }
    
    private func setUpLayout() {
        [initialCircle, groupNameLabel, groupNameField, underline, doneButton].forEach {
                    $0.translatesAutoresizingMaskIntoConstraints = false
                    view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            initialCircle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            initialCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            initialCircle.widthAnchor.constraint(equalToConstant: 120),
            initialCircle.heightAnchor.constraint(equalToConstant: 120),

            groupNameLabel.topAnchor.constraint(equalTo: initialCircle.bottomAnchor, constant: 32),
            groupNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),

            groupNameField.topAnchor.constraint(equalTo: groupNameLabel.bottomAnchor, constant: 8),
            groupNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            groupNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            groupNameField.heightAnchor.constraint(equalToConstant: 40),

            underline.topAnchor.constraint(equalTo: groupNameField.bottomAnchor, constant: 4),
            underline.leadingAnchor.constraint(equalTo: groupNameField.leadingAnchor),
            underline.trailingAnchor.constraint(equalTo: groupNameField.trailingAnchor),
            underline.heightAnchor.constraint(equalToConstant: 1),

            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            doneButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc private func groupNameChanged() {
        presenter?.didChangeGroupName(groupNameField.text ?? "")
    }
    
    @objc private func doneTapped() {
        presenter?.didTapDoneButton()
    }
    
    func updateInitialsCircle(with initials: String) {
        initialCircle.text = initials
    }
    
    func reloadMembers() {
//        buat apdet list member
    }
}

