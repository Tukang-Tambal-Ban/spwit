//
//  PlusButton.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 03/08/25.
//

import UIKit

final class PlusCircleButton: UIButton {
    init(size: CGFloat = 56) {
        super.init(frame: .zero)
        let config = UIImage.SymbolConfiguration(pointSize: size, weight: .regular)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: config)
        self.setImage(image, for: .normal)
        self.tintColor = .lightGreen
        self.backgroundColor = .clear
        self.layer.cornerRadius = size / 2
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        self.widthAnchor.constraint(equalToConstant: size).isActive = true
        self.heightAnchor.constraint(equalToConstant: size).isActive = true
        
        // Add some visual feedback
        self.setTitleColor(.lightGreen, for: .normal)
        self.setTitleColor(.lightGreen.withAlphaComponent(0.7), for: .highlighted)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
