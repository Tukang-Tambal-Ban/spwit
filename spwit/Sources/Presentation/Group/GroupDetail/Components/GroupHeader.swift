//
//  GroupHeader.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 04/08/25.
//

import UIKit

class GroupHeaderCardView: UIView {
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let subtitleLabel = UILabel()
    let settlementButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.cornerRadius = 18
        layer.borderWidth = 2
        layer.borderColor = UIColor.lightGreen.cgColor
        
        imageView.layer.cornerRadius = 32
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = Fonts.title3.bold
        nameLabel.textColor = .white
        
        subtitleLabel.font = Fonts.footnote.regular
        subtitleLabel.textColor = .plus
        
        settlementButton.setTitle("Settlement", for: .normal)
        settlementButton.backgroundColor = .lightGreen
        settlementButton.setTitleColor(.black, for: .normal)
        settlementButton.layer.cornerRadius = 12
        settlementButton.titleLabel?.font = Fonts.footnote.medium

        settlementButton.translatesAutoresizingMaskIntoConstraints = false

        [imageView, nameLabel, subtitleLabel, settlementButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 64),
            imageView.heightAnchor.constraint(equalToConstant: 64),

            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 6),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: settlementButton.leadingAnchor, constant: -8),

            subtitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            subtitleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),

            settlementButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            settlementButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            settlementButton.widthAnchor.constraint(equalToConstant: 96),
            settlementButton.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(groupName: String, groupImage: UIImage?, subtitle: String, subtitleColor: UIColor, onSettlement: (() -> Void)?) {
        nameLabel.text = groupName
        imageView.image = groupImage
        subtitleLabel.text = subtitle
        subtitleLabel.textColor = subtitleColor
        if let onSettlement = onSettlement {
            settlementButton.addTarget(nil, action: #selector(handleSettlement), for: .touchUpInside)
            objc_setAssociatedObject(settlementButton, &AssociationKey.action, onSettlement, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            settlementButton.isHidden = false
        } else {
            settlementButton.isHidden = true
        }
    }
    
    @objc private func handleSettlement(_ sender: UIButton) {
        if let action = objc_getAssociatedObject(sender, &AssociationKey.action) as? () -> Void {
            action()
        }
    }
}

private struct AssociationKey {
    static var action = "action"
}
