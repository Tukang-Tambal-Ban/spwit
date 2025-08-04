//
//  HomeViewController.swift
//  spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 31/07/25.
//

import UIKit

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
    
    private let loadingOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .lightGreen
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkBlue
        presenter?.viewDidLoad()
        setupLayout()
        setupTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchGroups()    // or whatever your “load data” call is
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
        
        view.addSubview(loadingOverlay)
        loadingOverlay.addSubview(activityIndicator)
        
        view.addSubview(errorLabel)
        
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
            
            loadingOverlay.topAnchor.constraint(equalTo: view.topAnchor),
              loadingOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor),
              loadingOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              loadingOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),

              activityIndicator.centerXAnchor.constraint(equalTo: loadingOverlay.centerXAnchor),
              activityIndicator.centerYAnchor.constraint(equalTo: loadingOverlay.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
               errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
               errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
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
    
    func showResult(from entity: GroupsEntity) {
        // Update summary labels
        lentAmountLabel.text = entity.overallSummary.youAreOwed.formattedRupiah
        oweAmountLabel.text = entity.overallSummary.youOwe.formattedRupiah

        // Clear existing cards
        groupCardsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // Handle empty state
        if entity.groups.isEmpty {
            showEmptyState()
            return
        }

        for group in entity.groups {
            let statusType: GroupCardStatus
            let statusText: String
            let statusAmount: String?

            switch group.status {
            case "settled":
                statusType = .settled
                statusText = "Settled"
                statusAmount = nil
            case "you_are_owed":
                statusType = .lent
                statusText = "You lent"
                statusAmount = group.amount.formattedRupiah
            case "you_owe":
                statusType = .owe
                statusText = "You owe"
                statusAmount = group.amount.formattedRupiah
            default:
                statusType = .settled
                statusText = "Settled"
                statusAmount = nil
            }

            let model = GroupCardModel(
                groupName: group.groupName,
                memberCount: group.members.count,
                statusText: statusText,
                statusAmount: statusAmount,
                statusType: statusType
            )

            let cardView = GroupCardView()
            cardView.configure(with: model)
            groupCardsStackView.addArrangedSubview(cardView)
        }

        // Show the list
        showGroupList()
    }
    
    func showError(_ error: Error) {
        headerStackView.isHidden = false
        financialSummaryStackView.isHidden = true
        welcomeStackView.isHidden = true
        scrollView.isHidden = true
        addButton.isHidden = true

        errorLabel.text = error.localizedDescription
        errorLabel.isHidden = false

        loadingOverlay.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func showLoading() {
        headerStackView.isHidden = false
        financialSummaryStackView.isHidden = true
        welcomeStackView.isHidden = true
        scrollView.isHidden = true
        addButton.isHidden = true
        errorLabel.isHidden = true // hide error if showing before

        loadingOverlay.isHidden = false
        activityIndicator.startAnimating()
    }

    func hideLoading() {
        headerStackView.isHidden = false
        financialSummaryStackView.isHidden = false
        scrollView.isHidden = false
        addButton.isHidden = false
        errorLabel.isHidden = true

        loadingOverlay.isHidden = true
        activityIndicator.stopAnimating()
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
