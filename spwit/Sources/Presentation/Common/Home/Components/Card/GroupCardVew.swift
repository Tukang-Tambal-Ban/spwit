//
//  GroupCardVew.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 04/08/25.
//

import UIKit

class GroupCardView: UIView {

    private let groupInitialsView = InitialsCircleView(initials: "GR", diameter: 48, bgColor: UIColor.grey)
    private let groupNameLabel = UILabel()
    private let memberIcon = UIImageView()
    private let memberCountLabel = UILabel()
    private let statusLabel = UILabel()
    private let statusAmountLabel = UILabel()
    private let statusCheckIcon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = UIColor(red: 21/255, green: 39/255, blue: 71/255, alpha: 1)
        layer.cornerRadius = 16
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
        // Set fixed height for the card
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        // Group Initials View
        groupInitialsView.translatesAutoresizingMaskIntoConstraints = false
        
        // Group Name
        groupNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        groupNameLabel.textColor = UIColor(red: 197/255, green: 255/255, blue: 25/255, alpha: 1) // neon green
        groupNameLabel.numberOfLines = 1
        groupNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Member Icon & Label
        memberIcon.image = UIImage(systemName: "person.2.fill")
        memberIcon.tintColor = .white
        memberIcon.translatesAutoresizingMaskIntoConstraints = false
        
        memberCountLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        memberCountLabel.textColor = .white
        memberCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Status
        statusLabel.applyStyle(Fonts.caption2.regular, color: .white)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        statusAmountLabel.applyStyle(Fonts.callout.semibold)
        statusAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        statusCheckIcon.image = UIImage(systemName: "checkmark.circle.fill")
        statusCheckIcon.tintColor = UIColor(red: 197/255, green: 255/255, blue: 25/255, alpha: 1)
        statusCheckIcon.translatesAutoresizingMaskIntoConstraints = false
        statusCheckIcon.isHidden = true
        
        // Layout
        addSubview(groupInitialsView)
        addSubview(groupNameLabel)
        addSubview(memberIcon)
        addSubview(memberCountLabel)
        addSubview(statusLabel)
        addSubview(statusAmountLabel)
        addSubview(statusCheckIcon)
        
        NSLayoutConstraint.activate([
            groupInitialsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            groupInitialsView.centerYAnchor.constraint(equalTo: centerYAnchor),
            groupInitialsView.widthAnchor.constraint(equalToConstant: 48),
            groupInitialsView.heightAnchor.constraint(equalToConstant: 48),
            
            groupNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            groupNameLabel.leadingAnchor.constraint(equalTo: groupInitialsView.trailingAnchor, constant: 12),
            groupNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusLabel.leadingAnchor, constant: -12),
            
            memberIcon.leadingAnchor.constraint(equalTo: groupNameLabel.leadingAnchor),
            memberIcon.topAnchor.constraint(equalTo: groupNameLabel.bottomAnchor, constant: 8),
            memberIcon.widthAnchor.constraint(equalToConstant: 14),
            memberIcon.heightAnchor.constraint(equalToConstant: 14),
            
            memberCountLabel.centerYAnchor.constraint(equalTo: memberIcon.centerYAnchor),
            memberCountLabel.leadingAnchor.constraint(equalTo: memberIcon.trailingAnchor, constant: 4),
            
            statusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            statusAmountLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 2),
            statusAmountLabel.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            
            statusCheckIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            statusCheckIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusCheckIcon.widthAnchor.constraint(equalToConstant: 24),
            statusCheckIcon.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with viewModel: GroupCardModel) {
        // Generate initials from group name
        let initials = viewModel.groupName.split(separator: " ").compactMap { $0.first }.prefix(2).map { String($0) }.joined().uppercased()
        groupInitialsView.label.text = initials
        
        // Generate background color based on group name
        let bgColor = generateColorFromName(viewModel.groupName)
        groupInitialsView.backgroundColor = bgColor
        
        groupNameLabel.text = viewModel.groupName
        memberCountLabel.text = "\(viewModel.memberCount)"
        
        // Reset all status elements
        statusLabel.isHidden = true
        statusAmountLabel.isHidden = true
        statusCheckIcon.isHidden = true
        
        switch viewModel.statusType {
        case .settled:
            statusLabel.text = "Settled"
            statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            statusLabel.textColor = .white
            statusCheckIcon.isHidden = false
        case .lent:
            statusLabel.text = "You lent"
            statusAmountLabel.text = viewModel.statusAmount
            statusAmountLabel.textColor = UIColor.lightGreen
            statusLabel.isHidden = false
            statusAmountLabel.isHidden = false
        case .owe:
            statusLabel.text = "You owe"
            statusAmountLabel.text = viewModel.statusAmount
            statusAmountLabel.textColor = UIColor.orange
            statusLabel.isHidden = false
            statusAmountLabel.isHidden = false
        case .none:
            break
        }
    }
    
    private func generateColorFromName(_ name: String) -> UIColor {
        let colors: [UIColor] = [
            UIColor.lightGreen,
            UIColor.grey,
            UIColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0), // Blue
            UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0), // Red
            UIColor(red: 0.8, green: 0.4, blue: 1.0, alpha: 1.0), // Purple
            UIColor(red: 1.0, green: 0.8, blue: 0.2, alpha: 1.0), // Yellow
        ]
        
        let hash = name.hashValue
        let index = abs(hash) % colors.count
        return colors[index]
    }
}

