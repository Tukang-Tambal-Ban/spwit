//
//  CreateGroupViewController.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 02/08/25.
//

import UIKit
protocol CreateGroupProtocol: AnyObject {
    func updateInitialsCircle(with initials: String)
    func reloadMembers(with members: [String])
    func renderNearbyAvatars(_ users: [String])
}

class CreateGroupViewController: UIViewController, CreateGroupProtocol {
    
    
    var presenter: CreateGroupPresenterProtocol?
    
    private func updateDoneButtonState(members: [String]) {
        let moreThanYou = members.filter { $0.lowercased() != "you" }.count > 0
        doneButton.isEnabled = moreThanYou
        doneButton.backgroundColor = moreThanYou ? .lightGreen : .grey
    }
    
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
        label.applyStyle(Fonts.callout.medium, color: .lightGreen)
        label.textAlignment = .left
        return label
    }()
    
    private let nearbyLabel: UILabel = {
        let label = UILabel()
        label.text = "Nearby"
        label.backgroundColor = .lightGreen
        label.applyStyle(Fonts.callout.medium, color: .black)
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private func updateNearbyLabelText(_ count: Int) {
        let text = "  • \(count) nearby"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 24
        paragraphStyle.alignment = .center

        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .font: Fonts.callout.medium,
                .foregroundColor: UIColor.black,
                .paragraphStyle: paragraphStyle,
                .baselineOffset: 2
            ]
        )
        nearbyLabel.attributedText = attributedString
        nearbyLabel.isHidden = count == 0
    }
    
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
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .grey
        button.layer.cornerRadius = 24
        return button
    }()
    
    private let memberLabel: UILabel = {
        let label = UILabel()
        label.text = "Members"
        label.applyStyle(Fonts.callout.medium, color: .lightGreen)
        label.textAlignment = .left
        return label
    }()
    
    private let memberScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        return scrollView
    }()
    
    private let memberStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 12
        sv.alignment = .top
        return sv
    }()
    
    private let addPeopleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Member"
        label.applyStyle(Fonts.callout.medium, color: .lightGreen)
        label.textAlignment = .left
        return label
    }()
    
    private let addPeopleHeaderStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        sv.alignment = .center
        sv.distribution = .fill
        return sv
    }()
    
    private let nearbyBadgeContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .lightGreen
        container.layer.cornerRadius = 16
        container.clipsToBounds = true
        return container
    }()
    
    private let nearbyBadge = NearbyLabel(count: 0)
    
    private let nearbyScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        return scrollView
    }()
    
    private let nearbyStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 12
        sv.alignment = .center
        return sv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBlue
        presenter?.viewDidLoad()
        setUpLayout()
        addPeopleHeaderStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addPeopleHeaderStack)
        addPeopleHeaderStack.addArrangedSubview(addPeopleLabel)
        addPeopleHeaderStack.addArrangedSubview(nearbyBadgeContainer)
        
        nearbyBadgeContainer.addSubview(nearbyBadge)
        nearbyBadge.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nearbyBadge.topAnchor.constraint(equalTo: nearbyBadgeContainer.topAnchor, constant: 8),
            nearbyBadge.bottomAnchor.constraint(equalTo: nearbyBadgeContainer.bottomAnchor, constant: -8),
            nearbyBadge.leadingAnchor.constraint(equalTo: nearbyBadgeContainer.leadingAnchor, constant: 12),
            nearbyBadge.trailingAnchor.constraint(equalTo: nearbyBadgeContainer.trailingAnchor, constant: -12),
            nearbyBadgeContainer.heightAnchor.constraint(equalToConstant: 32)
        ])
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
    }
    
    private func setUpLayout() {
        [initialCircle, groupNameLabel, groupNameField, underline, memberLabel, memberScrollView, memberStack, addPeopleHeaderStack, nearbyScrollView, nearbyStack, doneButton].forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(initialCircle)
        view.addSubview(groupNameLabel)
        view.addSubview(groupNameField)
        view.addSubview(underline)
        view.addSubview(memberLabel)
        view.addSubview(memberScrollView)
        memberScrollView.addSubview(memberStack)
        view.addSubview(addPeopleHeaderStack)
        view.addSubview(nearbyScrollView)
        nearbyScrollView.addSubview(nearbyStack)
        view.addSubview(doneButton)

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

                        memberLabel.topAnchor.constraint(equalTo: underline.bottomAnchor, constant: 24),
                        memberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                        memberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

                        memberScrollView.topAnchor.constraint(equalTo: memberLabel.bottomAnchor, constant: 12),
                        memberScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                        memberScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                        memberScrollView.heightAnchor.constraint(equalToConstant: 80),
                        
                        memberStack.topAnchor.constraint(equalTo: memberScrollView.topAnchor),
                        memberStack.leadingAnchor.constraint(equalTo: memberScrollView.leadingAnchor),
                        memberStack.trailingAnchor.constraint(equalTo: memberScrollView.trailingAnchor, constant: -20),
                        memberStack.bottomAnchor.constraint(equalTo: memberScrollView.bottomAnchor),
                        memberStack.heightAnchor.constraint(equalTo: memberScrollView.heightAnchor),

                        addPeopleHeaderStack.topAnchor.constraint(equalTo: memberScrollView.bottomAnchor, constant: 24),
                        addPeopleHeaderStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                        addPeopleHeaderStack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24),

                        nearbyScrollView.topAnchor.constraint(equalTo: addPeopleHeaderStack.bottomAnchor, constant: 12),
                        nearbyScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                        nearbyScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                        nearbyScrollView.heightAnchor.constraint(equalToConstant: 80),
                        
                        nearbyStack.topAnchor.constraint(equalTo: nearbyScrollView.topAnchor),
                        nearbyStack.leadingAnchor.constraint(equalTo: nearbyScrollView.leadingAnchor),
                        nearbyStack.trailingAnchor.constraint(equalTo: nearbyScrollView.trailingAnchor, constant: -20),
                        nearbyStack.bottomAnchor.constraint(equalTo: nearbyScrollView.bottomAnchor),
                        nearbyStack.heightAnchor.constraint(equalTo: nearbyScrollView.heightAnchor),

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
    
    @objc private func addPeopleTapped() {
        print("Plus button tapped!") // Debug print
        presenter?.didTapAddPeople()
    }
    
    @objc private func plusButtonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.alpha = 0.7
            sender.tintColor = .lightGreen.withAlphaComponent(0.7)
        }
    }
    
    @objc private func plusButtonTouchUp(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.alpha = 1.0
            sender.tintColor = .lightGreen
        }
    }
    
    func updateInitialsCircle(with initials: String) {
        initialCircle.text = initials
    }
    
    func reloadMembers(with members: [String]) {
        memberStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for name in members {
            let isCurrentUser = name.lowercased() == "you"
            let memberView = createMemberView(
                name: name,
                isCurrentUser: isCurrentUser,
                onRemoveTapped: { [weak self] in
                    self?.presenter?.didRemoveMember(name: name)
                }
            )
            memberStack.addArrangedSubview(memberView)
        }
        updateDoneButtonState(members: members)
    }
    
    func renderNearbyAvatars(_ users: [String]) {
        nearbyStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let plusButton = UIButton(type: .system)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.isUserInteractionEnabled = true
        
        let config = UIImage.SymbolConfiguration(pointSize: 56, weight: .regular)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: config)
        plusButton.setImage(image, for: .normal)
        plusButton.setImage(image, for: .highlighted)
        plusButton.tintColor = .lightGreen
        plusButton.setTitleColor(.lightGreen, for: .normal)
        plusButton.setTitleColor(.lightGreen.withAlphaComponent(0.7), for: .highlighted)
        plusButton.backgroundColor = .clear
        
        plusButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        plusButton.addTarget(self, action: #selector(addPeopleTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTouchDown), for: .touchDown)
        plusButton.addTarget(self, action: #selector(plusButtonTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        
        nearbyStack.addArrangedSubview(plusButton)

        for user in users {
            let nearbyUser = NearbyUserView(name: user, bgColor: .grey)
            nearbyUser.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(nearbyAvatarTapped(_:)))
            nearbyUser.addGestureRecognizer(tap)
            nearbyStack.addArrangedSubview(nearbyUser)
        }
        
        nearbyBadge.setText(users.count)
    }

    private func makeAvatarCircle(for name: String) -> UILabel {
        let label = UILabel()
        let initials = name.split(separator: " ").compactMap { $0.first }.prefix(2).map { String($0) }.joined().uppercased()
        label.text = initials
        label.applyStyle(Fonts.title3.bold, color: .darkBlue)
        label.backgroundColor = .gray
        label.textAlignment = .center
        label.layer.cornerRadius = 28
        label.clipsToBounds = true
        label.widthAnchor.constraint(equalToConstant: 56).isActive = true
        label.heightAnchor.constraint(equalToConstant: 56).isActive = true
        label.accessibilityLabel = name
        return label
    }

    @objc private func nearbyAvatarTapped(_ sender: UITapGestureRecognizer) {
        guard let nearbyUser = sender.view as? NearbyUserView else { return }
        presenter?.didSelectNearbyUser(name: nearbyUser.name)
    }

}

#if DEBUG
import SwiftUI

struct CreateGroupPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CreateGroupViewController {
        return CreateGroupViewController()
    }
    func updateUIViewController(_ uiViewController: CreateGroupViewController, context: Context) {}
}

struct CreateGroupViewController_Preview: PreviewProvider {
    static var previews: some View {
        CreateGroupPreview()
            .edgesIgnoringSafeArea(.all)
//            .previewDisplayName("UIKit: Sign In Screen")
    }
}
#endif

