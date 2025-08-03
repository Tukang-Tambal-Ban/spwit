//
//  PickerInputFieldView.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 03/08/25.
//


import UIKit

class PickerInputFieldView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - Public Properties
    var options: [String] = [] {
        didSet {
            picker.reloadAllComponents()
            if !options.isEmpty {
                input.text = options[0]
            } else {
                input.text = nil
            }
        }
    }
    var labelText: String = "" {
        didSet {
            label.text = labelText
        }
    }
    var selectedValue: String? {
        input.text
    }

    // MARK: - Private UI
    private let label = UILabel()
    let input = UITextField()
    private let picker = UIPickerView()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - UI Setup
    private func setup() {
        // Label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .callout).pointSize, weight: .regular)
        label.textColor = .lightGreen

        // Input
        input.translatesAutoresizingMaskIntoConstraints = false
        input.inputView = picker
        input.backgroundColor = .transparantGrey
        input.textColor = .white
        input.placeholder = "Select option"
        input.layer.cornerRadius = 8
        input.clipsToBounds = true
        input.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        input.leftViewMode = .always

        let chevronStack = UIStackView()
        chevronStack.axis = .vertical

        let chevronUp = UIImageView(image: UIImage(systemName: "chevron.up"))
        chevronUp.tintColor = .white
        let chevronDown = UIImageView(image: UIImage(systemName: "chevron.down"))
        chevronDown.tintColor = .white
        chevronStack.addArrangedSubview(chevronUp)
        chevronStack.addArrangedSubview(chevronDown)
        chevronStack.alignment = .center
        chevronStack.frame = CGRect(x: 0, y: 0, width: 0, height: 32)
        input.rightView = chevronStack
        input.rightViewMode = .always

        picker.delegate = self
        picker.dataSource = self

        addSubview(label)
        addSubview(input)




        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),


            input.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            input.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            input.trailingAnchor.constraint(equalTo: trailingAnchor),
            input.heightAnchor.constraint(equalToConstant: 48),
            input.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Picker Delegate/DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        options.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        options[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        input.text = options[row]
    }
}
