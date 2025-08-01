//
//  LabeledTextField.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//

import UIKit

class LabeledTextField: UIView {
    let label = UILabel()
    let textField = UITextField()

    init(labelText: String, placeholder: String) {
        super.init(frame: .zero)
        setupUI(labelText: labelText, placeholder: placeholder)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI(labelText: "", placeholder: "")
    }

    private func setupUI(labelText: String, placeholder: String) {
        // Label setup
        label.text = labelText
        label.textColor = UIColor(hex: "A4F000")
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false

        // Text field setup
//        textField.placeholder = placeholder
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = UIColor(hex: "1F2E46")
        textField.textColor = UIColor(hex: "A6A6A6")
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor(hex: "A6A6A6") // Example custom neon green
            ]
        )
        textField.layer.cornerRadius = 8
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.translatesAutoresizingMaskIntoConstraints = false

        // Add subviews
        addSubview(label)
        addSubview(textField)

        // Constraints
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),

            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 44),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor) // So component sizes itself
        ])
    }
}
