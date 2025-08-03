//
//  CreateNewSheetViewController.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 01/08/25.
//

import UIKit

protocol CreateNewSheetViewControllerProtocol: AnyObject {
    func dismissSheets()
}

class CreateNewSheetViewController: UIViewController, CreateNewSheetViewControllerProtocol {
    var presenter: CreateNewSheetPresenterProtocol?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create New"
        label.textColor = UIColor(red: 0.643, green: 0.941, blue: 0, alpha: 1)
        label.frame = CGRect(x: 0, y: 0, width: 108, height: 25)
        label.font = UIFont(name: "SFPro-bold", size: 25)
        label.textAlignment = .center
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "x.circle.fill", withConfiguration: symbolConfig)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(red: 0.643, green: 0.941, blue: 0, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }()

    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            makeActionButton(
                icon: "person.2.badge.plus.fill", title: "Create a Group",
                subtitle: "Add a new group", action: #selector(didTapGroup)),
            makeActionButton(
                icon: "camera.fill", title: "Capture Expense",
                subtitle: "Take a picture of your receipt", action: #selector(didTapPicture)),
            makeActionButton(
                icon: "square.and.pencil", title: "Add Expenses",
                subtitle: "Add your receipt manually", action: #selector(didTapManual)),
        ])
        sv.axis = .vertical
        sv.spacing = 16
        return sv
    }()

    //    private func makeActionButton(icon: String, title: String, subtitle: String, action: Selector) -> UIButton {
    //
    //        let button = UIButton(type: .system)
    //        let titleColor = UIColor(red: 0.643, green: 0.941, blue: 0, alpha: 1)
    //        let subtitleColor = UIColor.white
    //
    //        let attributedText = NSMutableAttributedString(
    //            string: "\(title)\n",
    //            attributes: [
    //                .font: UIFont(name: "SFPro-Semibold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .semibold),
    //                .foregroundColor: titleColor
    //            ]
    //        )
    //        attributedText.append(NSAttributedString(
    //            string: subtitle,
    //            attributes: [
    //                .font: UIFont(name: "SFPro-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12),
    //                .foregroundColor: subtitleColor
    //            ]
    //        ))
    //
    //        button.setAttributedTitle(attributedText, for: .normal)
    //        if let image = UIImage(systemName: icon) {
    //            button.setImage(image, for: .normal)
    //            button.tintColor = titleColor
    //            button.imageView?.contentMode = .scaleAspectFit
    //
    //            button.semanticContentAttribute = .forceLeftToRight
    //            button.contentHorizontalAlignment = .left
    //
    //            button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    //            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
    //        }
    //
    //        button.titleLabel?.numberOfLines = 2
    //        button.contentHorizontalAlignment = .left
    //        button.layer.cornerRadius = 10
    //        button.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.2)
    //        button.addTarget(self, action: action, for: .touchUpInside)
    //        return button
    //    }
    private func makeActionButton(icon: String, title: String, subtitle: String, action: Selector)
        -> UIButton
    {
        let titleColor = UIColor(red: 0.643, green: 0.941, blue: 0, alpha: 1)
        let subtitleColor = UIColor.white
        let backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.2)
        var attributedTitle = AttributedString()
        attributedTitle.append(
            AttributedString(
                "\(title)\n",
                attributes: AttributeContainer([
                    .font: UIFont(name: "SFPro-Semibold", size: 16)
                        ?? .systemFont(ofSize: 16, weight: .semibold),
                    .foregroundColor: titleColor,
                ])))
        attributedTitle.append(
            AttributedString(
                subtitle,
                attributes: AttributeContainer([
                    .font: UIFont(name: "SFPro-Regular", size: 12) ?? .systemFont(ofSize: 12),
                    .foregroundColor: subtitleColor,
                ])))
        let image = UIImage(systemName: icon)?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))

        var config = UIButton.Configuration.filled()

        config.attributedTitle = attributedTitle
        //        config.image = UIImage(systemName: icon)
        //        config.imagePlacement = .leading
        //        config.imagePadding = 14
        config.image = image
        config.imagePlacement = .leading
        config.imagePadding = 12
        config.titleAlignment = .leading
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 14, leading: 16, bottom: 14, trailing: 10)
        config.baseBackgroundColor = backgroundColor
        config.background.cornerRadius = 10

        let button = UIButton(configuration: config)
        //        button.tintColor = titleColor
        //        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapClose))
        closeButton.isUserInteractionEnabled = true
        closeButton.addGestureRecognizer(tapGesture)
    }

    private func setupLayout() {
        let container = UIView()
        container.backgroundColor = UIColor(red: 0.133, green: 0.251, blue: 0.427, alpha: 1)
        container.layer.cornerRadius = 10

        [titleLabel, closeButton, stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview($0)
        }
        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),

            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),

            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -40),
        ])
    }

    @objc private func didTapGroup() {
        presenter?.didTapGroup()
    }

    @objc private func didTapPicture() {
        presenter?.didTapPicture()
    }

    @objc private func didTapManual() {
        presenter?.didTapManual()
    }

    @objc private func didTapClose() {
        presenter?.didTapClose()
    }
    func dismissSheets() {
        dismiss(animated: true)
    }

}

#if DEBUG
    import SwiftUI

    struct SheetsViewPreview: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> CreateNewSheetViewController {
            return CreateNewSheetViewController()
        }
        func updateUIViewController(
            _ uiViewController: CreateNewSheetViewController, context: Context
        ) {}
    }

    struct SheetsViewViewController_Preview: PreviewProvider {
        static var previews: some View {
            SheetsViewPreview()
                .edgesIgnoringSafeArea(.all)
            //            .previewDisplayName("UIKit: Sign In Screen")
        }
    }
#endif
