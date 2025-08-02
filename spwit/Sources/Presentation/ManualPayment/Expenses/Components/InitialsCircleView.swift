//
//  InitialsCircleView.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//


import UIKit

class InitialsCircleView: UIView {
     let label = UILabel()
    
    init(initials: String, diameter: CGFloat = 48, bgColor: UIColor = UIColor(hex:"A4F000"), textColor: UIColor = .black, font: UIFont = .boldSystemFont(ofSize: 20)) {
        super.init(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        setup(initials: initials, diameter: diameter, bgColor: bgColor, textColor: textColor, font: font)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup(initials: "?", diameter: 48, bgColor: .systemBlue, textColor: .white, font: .boldSystemFont(ofSize: 20))
    }
    
    
    
    private func setup(initials: String, diameter: CGFloat, bgColor: UIColor, textColor: UIColor, font: UIFont) {
       
        backgroundColor = bgColor
        layer.cornerRadius = diameter / 2
        layer.masksToBounds = true
        
        label.text = initials
        label.textColor = textColor
        label.font = font
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 48),
            label.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
