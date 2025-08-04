//
//  AssignExpense.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/3/25.


import UIKit
class AssignExpenseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        expenseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "ExpenseCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        let item = expenseList[indexPath.row]
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        let isSelected = item.checked
        let radioImage = UIImage(systemName: isSelected ? "checkmark.circle.fill" : "circle")
//        radioImage.tintColor = .lightGreen
//        radioImage.translatesAutoresizingMaskIntoConstraints = false
        let checkIcon = UIImageView(image: radioImage)
        checkIcon.isUserInteractionEnabled = true
        checkIcon.tintColor = .lightGreen
        checkIcon.tag = indexPath.row
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleRadioTap(_:)))
        checkIcon.addGestureRecognizer(tap)
        checkIcon.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(checkIcon)
        
        
        let nameLabel = UILabel()
        nameLabel.text = item.name
        nameLabel.font = .boldSystemFont(ofSize: 22)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(nameLabel)
        
        let amountLabel = UILabel()
        amountLabel.text = item.amount
        amountLabel.font = .boldSystemFont(ofSize: 22)
        amountLabel.textColor = .white
        amountLabel.textAlignment = .right
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(amountLabel)
        
        if indexPath.row < expenseList.count - 1 {
            let separator = UIView()
            separator.backgroundColor = UIColor(white: 1, alpha: 0.13)
            separator.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(separator)
            NSLayoutConstraint.activate([
                separator.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                separator.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor),
                separator.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                separator.heightAnchor.constraint(equalToConstant: 1)
            ])
        }
        
        NSLayoutConstraint.activate([
            checkIcon.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            checkIcon.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 18),
            checkIcon.widthAnchor.constraint(equalToConstant: 32),
            checkIcon.heightAnchor.constraint(equalToConstant: 32),
            
            nameLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: checkIcon.trailingAnchor, constant: 12),
            
            amountLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -24)
        ])
        
        cell.backgroundColor = .transparantGrey
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    @objc func handleRadioTap(_ gesture: UITapGestureRecognizer) {
        guard let icon = gesture.view as? UIImageView else { return }
        let row = icon.tag

        expenseList[row].checked.toggle()

        let indexPath = IndexPath(row: row, section: 0)
        if let tableView = icon.superview?.superview as? UITableViewCell,
           let tv = tableView.superview as? UITableView {
            tv.reloadRows(at: [indexPath], with: .automatic)
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
    
    private let paidByView = PickerInputFieldView()
    private let splitView = PickerInputFieldView()
    let memberOptions = ["You", "Syatria", "Adit"]
    let splitOptions = ["Equally", "By Percentage", "Custom"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .darkBlue
        
        let titleExpense = UILabel()
        let amountExpense = UILabel()
        let doneButton = UIButton()
        
        
        titleExpense.translatesAutoresizingMaskIntoConstraints = false
        amountExpense.translatesAutoresizingMaskIntoConstraints = false
        paidByView.translatesAutoresizingMaskIntoConstraints = false
        splitView.translatesAutoresizingMaskIntoConstraints = false
        
        
        titleExpense.text = "Tiket Kapal"
        titleExpense.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .callout).pointSize, weight: .bold)
        titleExpense.textColor = .lightGreen
        
        amountExpense.text = "Rp 1.000.000"
        amountExpense.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .bold)
        amountExpense.textColor = .white
        
        
        paidByView.labelText = "Paid by"
        paidByView.options = memberOptions
        
        splitView.labelText = "Split"
        splitView.options = splitOptions
        
         let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none // custom separator later
        tableView.layer.cornerRadius = 20
        tableView.clipsToBounds = true
        tableView.dataSource = self
        tableView.delegate = self
        
        
        doneButton.setTitle("Done", for: UIControl.State.normal)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.backgroundColor = .lightGreen
        doneButton.layer.cornerRadius = 24
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.titleLabel?.font = .preferredFont(forTextStyle: .callout)
        
        
        
        view.addSubview(titleExpense)
        view.addSubview(amountExpense)
        view.addSubview(paidByView)
        view.addSubview(splitView)
        view.addSubview(tableView)
        view.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            titleExpense.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleExpense.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            amountExpense.topAnchor.constraint(equalTo: titleExpense.bottomAnchor, constant: 8),
            amountExpense.leadingAnchor.constraint(equalTo: titleExpense.leadingAnchor),
            
            paidByView.topAnchor.constraint(equalTo: amountExpense.bottomAnchor, constant: 40),
            paidByView.topAnchor.constraint(equalTo: splitView.topAnchor ),
            paidByView.bottomAnchor.constraint(equalTo: splitView.bottomAnchor),
            paidByView.leadingAnchor.constraint(equalTo: amountExpense.leadingAnchor),
            paidByView.trailingAnchor.constraint(equalTo: splitView.leadingAnchor, constant: -30),
            
            splitView.topAnchor.constraint(equalTo: paidByView.topAnchor, constant: 40),
            splitView.bottomAnchor.constraint(equalTo: paidByView.bottomAnchor),
            splitView.leadingAnchor.constraint(equalTo: paidByView.trailingAnchor),
            splitView.trailingAnchor.constraint(equalTo: amountExpense.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: splitView.bottomAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: 200),
            
            doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.widthAnchor.constraint(equalToConstant: 360),
            doneButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}


import SwiftUI
struct AssignExpense_Preview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return AssignExpenseViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct AssignExpenseController_PreviewProvider: PreviewProvider {
    static var previews: some View {
        AssignExpense_Preview()
            .edgesIgnoringSafeArea(.all)
    }
}
