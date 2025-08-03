//
//  NearbyLabel.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 03/08/25.
//

import UIKit

final class NearbyLabel: UILabel {
    init(count: Int) {
        super.init(frame: .zero)
        self.textAlignment = .center
        self.isHidden = count == 0
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setContentHuggingPriority(.required, for: .horizontal)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)
        self.setText(count)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func setText(_ count: Int) {
        let text = "• \(count) nearby"
        self.text = text
        self.font = Fonts.callout.medium
        self.textColor = .black
        self.textAlignment = .center
        self.isHidden = count == 0
    }
}

