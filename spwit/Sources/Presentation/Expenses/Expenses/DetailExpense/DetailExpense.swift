//
//  DetailExpense.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/3/25.
//


import UIKit

class DetailExpenseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell") ?? UITableViewCell(style: .default, reuseIdentifier: "MemberCell")
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        cell.contentView.subviews.forEach{
            $0.removeFromSuperview()
        }
        
        let item = expenseList[indexPath.row]
        cell.contentView.subviews.forEach{
            $0.removeFromSuperview()
        }
        
       
        let paidRow = PaidRowView(paidBy: item.name, amountText: item.amount, isOwe: true, isPaid:  false)
        paidRow.translatesAutoresizingMaskIntoConstraints = false

        cell.contentView.addSubview(paidRow)
        
        
        NSLayoutConstraint.activate([
                paidRow.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                paidRow.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                paidRow.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
                paidRow.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
            ])
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    // For dynamic layout
    private let borderWidth: CGFloat = 3
    private let borderView = UIView()
    private let cardView = UIView()
    private let borderGradient = CAGradientLayer()
    private let fillGradient = CAGradientLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .darkBlue
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.layer.cornerRadius = 9
        borderView.clipsToBounds = true
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.layer.cornerRadius = 9
        cardView.clipsToBounds = true

        fillGradient.colors = [
            UIColor.gradiantGreen.cgColor,
            UIColor.gradiantBlue.cgColor,
            
        ]
        fillGradient.startPoint = CGPoint(x: 0, y: 0)
        fillGradient.endPoint = CGPoint(x: 0, y: 1)
        cardView.layer.insertSublayer(fillGradient, at: 0)
        
        
        let borderGradient = CAGradientLayer()
        borderGradient.colors = [
            UIColor.lightGreen.cgColor,
            UIColor.lightBlue.cgColor
        ]
        borderGradient.startPoint = CGPoint(x: 0, y: 1)
        borderGradient.endPoint = CGPoint(x: 0, y: 0)
        borderView.layer.insertSublayer(borderGradient, at: 0)
        
        
        let titleExpanse = UILabel()
        titleExpanse.translatesAutoresizingMaskIntoConstraints = false
        titleExpanse.text = "Tiket Kapal"
        titleExpanse.applyStyle(Fonts.headline.bold, color: .white)
        
        let amountExpanse = UILabel()
        amountExpanse.translatesAutoresizingMaskIntoConstraints = false
        amountExpanse.text = "Rp. 100.000"
        amountExpanse.applyStyle(Fonts.largeTitle.bold, color: .lightGreen)
        
        let timeStampEspense = UILabel()
        timeStampEspense.translatesAutoresizingMaskIntoConstraints = false
        timeStampEspense.text = "Added by You on 29 June 2025"
        timeStampEspense.applyStyle(Fonts.footnote.regular, color: .white)
        
//        paid by you section , can be used for the list !
        let paidAvatar = InitialsCircleView(initials: "ME", diameter: 44, bgColor: .lightGreen, textColor: .black, font: .preferredFont(forTextStyle: .body) )
        
        paidAvatar.translatesAutoresizingMaskIntoConstraints = false
        
        let paidValue = UILabel()
        paidValue.text = "You paid"
        paidValue.applyStyle(Fonts.callout.bold, color: .white)
        paidValue.translatesAutoresizingMaskIntoConstraints = false
        
        let paidPrice = UILabel()
        paidPrice.text  = "Rp. 100.000"
        paidPrice.applyStyle(Fonts.callout.bold, color: .lightGreen)
        paidPrice.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        tableView.delegate = self
        tableView.backgroundColor = .clear
        

        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        cardView.addSubview(titleExpanse)
        cardView.addSubview(amountExpanse)
        cardView.addSubview(timeStampEspense)
        borderView.addSubview(cardView)
        view.addSubview(borderView)
        view.addSubview(paidAvatar)
        view.addSubview(paidValue)
        view.addSubview(paidPrice)
        
        
        NSLayoutConstraint.activate([
            
           
            

            borderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            borderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            borderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            borderView.heightAnchor.constraint(equalToConstant: 232),

            
            cardView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: borderWidth),
            cardView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -borderWidth),
            cardView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: borderWidth),
            cardView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -borderWidth),
            
            titleExpanse.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 59),
            titleExpanse.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 27),
            amountExpanse.topAnchor.constraint(equalTo: titleExpanse.bottomAnchor, constant: 16),
            amountExpanse.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 27),
            
            timeStampEspense.topAnchor.constraint(equalTo: amountExpanse.bottomAnchor,constant: 16),
            timeStampEspense.leadingAnchor.constraint(equalTo: amountExpanse.leadingAnchor ),
            
            paidAvatar.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 36),
            paidAvatar.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            
            paidAvatar.heightAnchor.constraint(equalToConstant: 44),
            paidAvatar.widthAnchor.constraint(equalToConstant: 44),
            
            paidValue.topAnchor.constraint(equalTo: paidAvatar.topAnchor),
            paidValue.bottomAnchor.constraint(equalTo: paidAvatar.bottomAnchor),
            paidValue.leadingAnchor.constraint(equalTo: paidAvatar.trailingAnchor, constant: 12),
            
            
            paidPrice.topAnchor.constraint(equalTo: paidValue.topAnchor),
            paidPrice.bottomAnchor.constraint(equalTo: paidValue.bottomAnchor),
            paidPrice.leadingAnchor.constraint(equalTo: paidValue.trailingAnchor, constant: 6),
            
            
            
            
            
            tableView.topAnchor.constraint(equalTo: paidPrice.bottomAnchor),
            
            tableView.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 28),
            
            tableView.trailingAnchor.constraint(equalTo:view.trailingAnchor),
            
            tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor)
        
            
        ])
        

        view.layoutIfNeeded()
        borderGradient.frame = borderView.bounds
        fillGradient.frame = cardView.bounds
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        borderGradient.frame = borderView.bounds
        fillGradient.frame = cardView.bounds
    }
}



import SwiftUI
struct DetailExpense_Preview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return DetailExpenseViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct DetailExpenseController_PreviewProvider: PreviewProvider {
    static var previews: some View {
        DetailExpense_Preview()
            .edgesIgnoringSafeArea(.all)
    }
}
