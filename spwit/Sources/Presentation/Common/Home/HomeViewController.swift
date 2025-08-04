//
//  HomeViewController.swift
//  spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 31/07/25.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func showWelcomeMessages()
    func showGroupList()
    func hideWelcomeMessages()
}

class HomeViewController: UIViewController, HomeViewProtocol {
    func showWelcomeMessages() {
        welcomeStackView.isHidden = false
        groupCardsStackView.isHidden = true
    }
    
    func showGroupList() {
        welcomeStackView.isHidden = true
        groupCardsStackView.isHidden = false
    }
    
    func hideWelcomeMessages() {
        welcomeStackView.isHidden = true
    }

    var presenter: HomePresenterProtocol?

    private let welcomeStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Start Splitting Your Expense"
        label.textColor = UIColor.lightGreen
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap the plus button to get started."
        label.textColor = UIColor.lightGreen.withAlphaComponent(0.5)
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let headerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "SPWIT"
        label.textColor = UIColor.lightGreen
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        let image = UIImage(systemName: "person.circle.fill", withConfiguration: symbolConfig)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.lightGreen
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    private let financialSummaryStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let lentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let lentLabel: UILabel = {
        let label = UILabel()
        label.text = "Overall, You lent"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lentAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "Rp1.000.000"
        label.textColor = UIColor.lightGreen
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let oweStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let oweLabel: UILabel = {
        let label = UILabel()
        label.text = "You owe"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let oweAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "Rp2.000.000"
        label.textColor = UIColor.orange
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 90, weight: .regular)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.lightGreen
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let groupCardsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkBlue
        presenter?.viewDidLoad()
        setupLayout()
        setupTapGesture()
        showGroupCards()
    }

    private func setupLayout() {
        [headerStackView, financialSummaryStackView, welcomeStackView, scrollView, addButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        headerStackView.addArrangedSubview(logoLabel)
        headerStackView.addArrangedSubview(profileButton)
        
        lentStackView.addArrangedSubview(lentLabel)
        lentStackView.addArrangedSubview(lentAmountLabel)
        oweStackView.addArrangedSubview(oweLabel)
        oweStackView.addArrangedSubview(oweAmountLabel)
        
        financialSummaryStackView.addArrangedSubview(lentStackView)
        financialSummaryStackView.addArrangedSubview(oweStackView)
        
        welcomeStackView.addArrangedSubview(titleLabel)
        welcomeStackView.addArrangedSubview(subtitleLabel)
        
        scrollView.addSubview(groupCardsStackView)
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            financialSummaryStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 24),
            financialSummaryStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            financialSummaryStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            welcomeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            scrollView.topAnchor.constraint(equalTo: financialSummaryStackView.bottomAnchor, constant: 24),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -32),
            
            groupCardsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            groupCardsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            groupCardsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            groupCardsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            groupCardsStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),

            addButton.widthAnchor.constraint(equalToConstant: 90),
            addButton.heightAnchor.constraint(equalToConstant: 90),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    private func showGroupCards() {
        groupCardsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // dummy group cards
        let card1 = GroupCardView()
        card1.configure(with: .init(
            groupName: "🇯🇵 Bismillah OTW Jepang",
            memberCount: 4,
            statusText: "Settled",
            statusAmount: nil,
            statusType: .settled
        ))
        let card2 = GroupCardView()
        card2.configure(with: .init(
            groupName: "Tukang Tambal Ban",
            memberCount: 4,
            statusText: "You lent",
            statusAmount: "Rp100.000",
            statusType: .lent
        ))
        let card3 = GroupCardView()
        card3.configure(with: .init(
            groupName: "Singapur Lesgo?",
            memberCount: 4,
            statusText: "You owe",
            statusAmount: "Rp500.000",
            statusType: .owe
        ))
        let card4 = GroupCardView()
        card4.configure(with: .init(
            groupName: "Singapur j?",
            memberCount: 4,
            statusText: "You owe",
            statusAmount: "Rp500.000",
            statusType: .owe
        ))
        let card5 = GroupCardView()
        card5.configure(with: .init(
            groupName: "Singapur j?",
            memberCount: 4,
            statusText: "You owe",
            statusAmount: "Rp500.000",
            statusType: .owe
        ))
        let card6 = GroupCardView()
        card6.configure(with: .init(
            groupName: "Singapur j?",
            memberCount: 4,
            statusText: "You owe",
            statusAmount: "Rp500.000",
            statusType: .owe
        ))

        [card1, card2, card3, card4, card5, card6].forEach { groupCardsStackView.addArrangedSubview($0) }
        
        // Show group list and hide welcome message
        showGroupList()
    }
    
    private func showEmptyState() {
        // Clear existing cards
        groupCardsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Show welcome message
        showWelcomeMessages()
    }

    private func setupTapGesture() {
        profileButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }

    @objc func addTapped() {
        presenter?.didTapAddButton()
    }
    @objc func profileTapped() {
        presenter?.didTapProfileButton()
    }
}

#if DEBUG
    import SwiftUI

    struct HomeViewPreview: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> HomeViewController {
            return HomeViewController()
        }
        func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {}
    }

    struct HomeViewViewController_Preview: PreviewProvider {
        static var previews: some View {
            HomeViewPreview()
                .edgesIgnoringSafeArea(.all)
            //            .previewDisplayName("UIKit: Sign In Screen")
        }
    }
#endif
