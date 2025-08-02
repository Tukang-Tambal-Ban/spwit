//
//  Untitled.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//

import UIKit

protocol AddExpensesView: AnyObject {
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
}

class AddExpensesViewController : UIViewController, AddExpensesViewProtocol {
    func didNextTapped() {
        
    }
    
    func didBackTapped() {
        
    }
    
    
    var presenter = AddExpensesPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI(){
        view.backgroundColor = UIColor(hex: "#0F213C")
        
        //        titleExpanse.text = "E.g Taxi"
        //        titleExpanse.textColor = .lightGray
        //        titleExpanse.font = UIFont.systemFont(ofSize: 16)
        //        titleExpanse.backgroundColor = .white
        
        let titleExpanse = LabeledTextField(labelText: "What is this for", placeholder: "e.g taxi")
        titleExpanse.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleExpanse)
        
        let amountExpanse = LabeledTextField(labelText: "Amount", placeholder: "Rp0")
        amountExpanse.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(amountExpanse)
        
//        Navbar
        title = "Add  Expenses"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(hex: "#0F213C"), // <-- Your title color here!
            .font: UIFont.boldSystemFont(ofSize: 20) // Optional: change font
        ]
        navigationController?.navigationBar.tintColor = .systemGreen
        // Apply to the navigation bar
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
     
        
        let leftBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "chevron.left"), // or use .title: "Back"
                style: .plain,
                target: self,
                action: #selector(backTapped)
            )
        
        let infoButton = UIBarButtonItem(
            title: "next",
            style: .plain,
            target: self,
            action: #selector(nextTapped)
        )
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = infoButton
        
        
        NSLayoutConstraint.activate([
            titleExpanse.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleExpanse.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleExpanse.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            amountExpanse.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            amountExpanse.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            amountExpanse.topAnchor.constraint(equalTo: titleExpanse.bottomAnchor, constant: 20),
            
            
            
            
            
            
        ]  )
        
    }
    
    @objc func backTapped() {
        presenter.didBackTapped()
    }
    
    @objc func nextTapped() {
        presenter.didNextTapped()
    }
}




#if DEBUG
import SwiftUI

struct AddExpensesPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> AddExpensesViewController {
        return AddExpensesViewController()
    }
    func updateUIViewController(_ uiViewController: AddExpensesViewController, context: Context) {}
}

struct AddExpensesViewController_Previews: PreviewProvider {
    static var previews: some View {
        AddExpensesPreview()
            .edgesIgnoringSafeArea(.all)
            .previewDisplayName("UIKit: Sign In Screen")
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(Text("Add  Expenses"))
            
    }
}
#endif
