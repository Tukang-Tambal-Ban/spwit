//
//  AvatarCircles.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 03/08/25.
//

import UIKit

final class AvatarCircle: UILabel {
    init(initials: String, diameter: CGFloat = 56, bgColor: UIColor = .grey) {
        super.init(frame: .zero)
        self.text = initials
        self.applyStyle(Fonts.title3.bold, color: .darkBlue)
        self.backgroundColor = bgColor
        self.textAlignment = .center
        self.layer.cornerRadius = diameter / 2
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: diameter).isActive = true
        self.heightAnchor.constraint(equalToConstant: diameter).isActive = true
        self.accessibilityLabel = initials
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    static func fromName(_ name: String, diameter: CGFloat = 56, bgColor: UIColor = .grey) -> AvatarCircle {
        let initials = name.split(separator: " ").compactMap { $0.first }.prefix(2).map { String($0) }.joined().uppercased()
        let avatar = AvatarCircle(initials: initials, diameter: diameter, bgColor: bgColor)
        avatar.accessibilityLabel = name
        return avatar
    }
}
