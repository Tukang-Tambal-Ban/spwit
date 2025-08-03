//
//  MemberCircle.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 03/08/25.
//

import UIKit

final class MemberCircleView: UIView {
    private let avatar: AvatarCircle
    private let nameLabel: UILabel
    private let memberName: String

    init(name: String, diameter: CGFloat = 56, bgColor: UIColor = .lightGreen) {
        self.memberName = name
        self.avatar = AvatarCircle.fromName(name, diameter: diameter, bgColor: bgColor)

        self.nameLabel = UILabel()
        self.nameLabel.text = name
        self.nameLabel.applyStyle(Fonts.caption1.medium, color: .white)
        self.nameLabel.textAlignment = .center
        self.nameLabel.adjustsFontSizeToFitWidth = true

        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false

        let stack = UIStackView(arrangedSubviews: [avatar, nameLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            avatar.widthAnchor.constraint(equalToConstant: diameter),
            avatar.heightAnchor.constraint(equalToConstant: diameter),
            nameLabel.widthAnchor.constraint(equalTo: avatar.widthAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var name: String {
        return memberName
    }
}

final class NearbyUserView: UIView {
    private let avatar: AvatarCircle
    private let nameLabel: UILabel
    private let userName: String

    init(name: String, diameter: CGFloat = 56, bgColor: UIColor = .grey) {
        self.userName = name
        self.avatar = AvatarCircle.fromName(name, diameter: diameter, bgColor: bgColor)

        self.nameLabel = UILabel()
        self.nameLabel.text = name
        self.nameLabel.applyStyle(Fonts.caption1.medium, color: .white)
        self.nameLabel.textAlignment = .center
        self.nameLabel.adjustsFontSizeToFitWidth = true

        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false

        let stack = UIStackView(arrangedSubviews: [avatar, nameLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            avatar.widthAnchor.constraint(equalToConstant: diameter),
            avatar.heightAnchor.constraint(equalToConstant: diameter),
            nameLabel.widthAnchor.constraint(equalTo: avatar.widthAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var name: String {
        return userName
    }
}

final class RemovableMemberCircleView: UIView {
    private let avatar: AvatarCircle
    private let nameLabel: UILabel
    private let removeButton: UIButton
    private var onRemoveTapped: (() -> Void)?
    private let memberName: String
    
    init(name: String, diameter: CGFloat = 56, onRemoveTapped: (() -> Void)? = nil) {
        self.memberName = name
        self.avatar = AvatarCircle.fromName(name, diameter: diameter, bgColor: .lightGreen)
        self.nameLabel = UILabel()
        self.nameLabel.text = name
        self.nameLabel.applyStyle(Fonts.caption1.medium, color: .white)
        self.nameLabel.textAlignment = .center
        self.nameLabel.adjustsFontSizeToFitWidth = true
        
        self.removeButton = UIButton(type: .system)
        self.onRemoveTapped = onRemoveTapped
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupRemoveButton()
        
        let stack = UIStackView(arrangedSubviews: [avatar, nameLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)
        addSubview(removeButton)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            avatar.widthAnchor.constraint(equalToConstant: diameter),
            avatar.heightAnchor.constraint(equalToConstant: diameter),
            nameLabel.widthAnchor.constraint(equalTo: avatar.widthAnchor),
            
            removeButton.widthAnchor.constraint(equalToConstant: 20),
            removeButton.heightAnchor.constraint(equalToConstant: 20),
            removeButton.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            removeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            
            widthAnchor.constraint(greaterThanOrEqualToConstant: diameter + 10)
        ])
    }
    
    private func setupRemoveButton() {
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
        let image = UIImage(systemName: "x.circle.fill", withConfiguration: config)
        removeButton.setImage(image, for: .normal)
        removeButton.tintColor = UIColor(red: 0, green: 0.655, blue: 0.502, alpha: 1)
        removeButton.layer.cornerRadius = 12
        removeButton.clipsToBounds = true
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func removeButtonTapped() {
        onRemoveTapped?()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var name: String {
        return memberName
    }
}

func createMemberView(name: String, isCurrentUser: Bool = false, onRemoveTapped: (() -> Void)? = nil) -> UIView {
    if isCurrentUser {
        return MemberCircleView(name: name, bgColor: .lightGreen)
    } else {
        return RemovableMemberCircleView(name: name, onRemoveTapped: onRemoveTapped)
    }
}
