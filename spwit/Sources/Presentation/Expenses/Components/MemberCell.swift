//
//  MemberCell.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/2/25.
//


import UIKit

class MemberCell: UICollectionViewCell {
    static let identifier = "MemberCell"
    var presenter: AddPeoplePresenter?
    
    let initialsView = InitialsCircleView(initials: "AB", diameter: 48, bgColor: UIColor(hex:"A4F000"))
    let nameLabel = UILabel()
    private let onlineDot = UIView()
    
    func configureAsAddButton(bgColor: UIColor) {
        initialsView.label.text = "+"
        initialsView.backgroundColor = bgColor
        nameLabel.text = ""
        onlineDot.isHidden = true
        initialsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchPeople)))
    }
    
    @objc func searchPeople() {
        presenter?.navigateSearch()
    }
    
    func configure(with member: MemberEntity, bgColor : UIColor? = nil, showOnlineDot : Bool = false) {
        initialsView.label.text = member.initials
        if let bgColor = bgColor {
            initialsView.backgroundColor = bgColor
            
        }
        nameLabel.text = member.name
        onlineDot.isHidden = !showOnlineDot

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialsView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 10)
        nameLabel.textColor = .white
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .center
        
        
        onlineDot.backgroundColor = UIColor(hex: "A4F000")
        onlineDot.layer.cornerRadius = 8 // dot is 16x16
        onlineDot.translatesAutoresizingMaskIntoConstraints = false
        onlineDot.isHidden = true // hidden by default!
        
        contentView.addSubview(initialsView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(onlineDot)
        
        NSLayoutConstraint.activate([
            initialsView.topAnchor.constraint(equalTo: contentView.topAnchor),
            initialsView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            initialsView.widthAnchor.constraint(equalToConstant: 48),
            initialsView.heightAnchor.constraint(equalToConstant: 48),
            nameLabel.topAnchor.constraint(equalTo: initialsView.bottomAnchor, constant: 6),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            onlineDot.widthAnchor.constraint(equalToConstant: 16),
            onlineDot.heightAnchor.constraint(equalToConstant: 16),
            onlineDot.topAnchor.constraint(equalTo: initialsView.topAnchor, constant: 4),
            onlineDot.trailingAnchor.constraint(equalTo: initialsView.trailingAnchor, constant: 8),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum MemberCellType {
    case addButton
    case member(MemberEntity)
}
