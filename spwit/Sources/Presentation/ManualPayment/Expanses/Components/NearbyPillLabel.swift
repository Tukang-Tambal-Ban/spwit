//
//  NearbyPillLabel.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/2/25.
//
import UIKit

class NearbyPillLabel: UILabel {
    init(count: Int) {
        super.init(frame: .infinite)
        self.text = " • \(count) nearby   "
        self.textColor = .black
        self.backgroundColor = UIColor(hex: "A4F000")
        self.font = UIFont.systemFont(ofSize: 13) // Adjust as needed
        self.layer.cornerRadius = 15 // Half of height for pill shape
        self.layer.masksToBounds = true
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
