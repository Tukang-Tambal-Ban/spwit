//
//  TimelineSection.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 04/08/25.
//
import UIKit

class TimelineSectionHeader: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.font = Fonts.title3.bold
        self.textColor = .lightGreen
    }
    required init?(coder: NSCoder) { fatalError() }
}
