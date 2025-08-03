//
//  AddPeopleViewController.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//

import UIKit
protocol AddPeopleViewProtocol : AnyObject {
    
}

class AddPeopleViewController: UIViewController, AddPeopleViewProtocol, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var presenter: AddPeoplePresenter?
    
    let members : [MemberEntity] = [
        MemberEntity(name:"Muhammad Rifqi"),
        MemberEntity(name:"Aditya Putra"),
        MemberEntity(name:"Raiza Hafida "),
        MemberEntity(name:"Shafa Tiara"),
        MemberEntity(name:"Nada Hanifah"),
        
    ]
    
    let peoples : [MemberEntity] = [
        MemberEntity(name:"rifqi ganteng"),
        MemberEntity(name:"Aditya seksi"),
        MemberEntity(name:"Raiza Ughtea "),
        MemberEntity(name:"Shafa Ughtea"),
        MemberEntity(name:"Nada Ungkeher"),
        MemberEntity(name:"Nada Ungkeher"),
        MemberEntity(name:"Nada Ungkeher"),
        MemberEntity(name:"Nada Ungkeher"),
        MemberEntity(name:"Nada Ungkeher"),
        MemberEntity(name:"Nada Ungkeher"),
        
    ]
    
    let groups : [MemberEntity] = [
        MemberEntity(name:"Group A"),
        MemberEntity(name:"Group B"),
        MemberEntity(name:"Tukang Tambal Ban"),
        MemberEntity(name:"Ti Amor"),
        MemberEntity(name:"Ungkeh UNghre Ungkeher"),
        
    ]
    
    var cellItems: [MemberCellType] {
        var arr: [MemberCellType] = [.addButton]
        arr += peoples.map { .member($0) }
        return arr
    }
    
    
    
    private let sectionLabelMember: UILabel = {
        let label = UILabel()
        label.text = "Add Member"
        label.textColor = UIColor(hex:"A4F000")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let sectionLabelPeople: UILabel = {
        let label = UILabel()
        label.text = "Add People"
        label.textColor = UIColor(hex:"A4F000")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sectionLabelGroup: UILabel = {
        let label = UILabel()
        label.text = "Group"
        label.textColor = UIColor(hex:"A4F000")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //
    //    private let nearbyLabel : UILabel ={
    //        let label = UILabel()
    //        label.text = "Nearby"
    //    }()
    
    lazy var memberCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: 48, height: 70)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MemberCell.self, forCellWithReuseIdentifier: MemberCell.identifier)
        return cv
        
    }()
    
    lazy var groupCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: 48, height: 70)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MemberCell.self, forCellWithReuseIdentifier: MemberCell.identifier)
        return cv
        
    }()
    
    lazy var peoplesCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: 48, height: 70)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MemberCell.self, forCellWithReuseIdentifier: MemberCell.identifier)
        return cv
        
    }()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == memberCollectionView {
            return members.count
        } else if collectionView == peoplesCollectionView {
            return cellItems.count
        } else if collectionView == groupCollectionView {
            return groups.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberCell.identifier, for: indexPath) as! MemberCell
        cell.presenter = presenter
        if collectionView == memberCollectionView {
            cell.configure(with: members[indexPath.item],bgColor: UIColor(hex:"A4F000"))
            return cell
        } else if collectionView == peoplesCollectionView {
            switch cellItems[indexPath.item]{
            case .addButton:
                cell.configureAsAddButton(bgColor: UIColor(hex: "A4F000"))
            case .member(let peoples):
                cell.configure(with: peoples,bgColor: UIColor(hex:"999999"),showOnlineDot: true)
            }
            
            return cell
            
        } else if collectionView == groupCollectionView {
            cell.configure(with: groups[indexPath.item],bgColor: UIColor(hex:"999999"))
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(hex: "#0F213C")
        setupUIAddMember()
        setupUIAddPeople()
        setupUIAddGroup()
<<<<<<< HEAD:spwit/Sources/Presentation/Expenses/AddPeople/AddMemberViewController.swift
        setupNavBar()
        
    }
    
    private func setupNavBar() {
        
//        Navbar
        title = "Add People or Group"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.lightGreen,
            .font: UIFont.boldSystemFont(ofSize: 20) // Optional: change font
        ]
        navigationController?.navigationBar.tintColor = UIColor.lightGreen
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
            title: "Next",
            style: .plain,
            target: self,
            action: #selector(nextTapped)
        )
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = infoButton
    }
    
    @objc func backTapped() {
        presenter?.didBackTapped()
    }
    
    @objc func nextTapped() {
        presenter?.didNextTapped()
=======
>>>>>>> e654a5c (refactor: memperbaiki UI dan logic dari add people nearby in create group):spwit/Sources/Presentation/ManualPayment/Expenses/AddMember/AddMemberViewController.swift
    }
    
    private func setupUIAddGroup() {
        view.addSubview(sectionLabelGroup)
        view.addSubview(groupCollectionView)
        
        NSLayoutConstraint.activate([
            sectionLabelGroup.topAnchor.constraint(equalTo: peoplesCollectionView.bottomAnchor, constant: 20),
            sectionLabelGroup.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            
            groupCollectionView.topAnchor.constraint(equalTo: sectionLabelGroup.bottomAnchor, constant: 16),
            groupCollectionView.leadingAnchor.constraint(equalTo: sectionLabelGroup.leadingAnchor),
            groupCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            groupCollectionView.heightAnchor.constraint(equalToConstant: 78)
        ])
    }
    
    private func setupUIAddPeople() {
        
        let nearbyLabel = NearbyPillLabel(count: 121)
        view.addSubview(sectionLabelPeople)
        view.addSubview(nearbyLabel)
        view.addSubview(peoplesCollectionView)
        
        NSLayoutConstraint.activate([
            sectionLabelPeople.topAnchor.constraint(equalTo: memberCollectionView.bottomAnchor, constant: 20),
            sectionLabelPeople.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            //            sectionLabelPeople.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 16),
            
            nearbyLabel.leadingAnchor.constraint(equalTo: sectionLabelPeople.trailingAnchor, constant: 6),
            nearbyLabel.centerYAnchor.constraint(equalTo: sectionLabelPeople.centerYAnchor),
            nearbyLabel.heightAnchor.constraint(equalToConstant: 30),
            nearbyLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            peoplesCollectionView.topAnchor.constraint(equalTo: sectionLabelPeople.bottomAnchor, constant: 16),
            peoplesCollectionView.leadingAnchor.constraint(equalTo: sectionLabelPeople.leadingAnchor),
            peoplesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            peoplesCollectionView.heightAnchor.constraint(equalToConstant: 78)
        ])
        
    }
    
    private func setupUIAddMember() {
        view.addSubview(sectionLabelMember)
        view.addSubview(memberCollectionView)
        
        NSLayoutConstraint.activate([
            sectionLabelMember.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            sectionLabelMember.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sectionLabelMember.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            memberCollectionView.topAnchor.constraint(equalTo: sectionLabelMember.bottomAnchor, constant: 16),
            memberCollectionView.leadingAnchor.constraint(equalTo: sectionLabelMember.leadingAnchor),
            memberCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            memberCollectionView.heightAnchor.constraint(equalToConstant: 78)
        ])
    }
    
}

import SwiftUI

struct AddMemberViewController_Preview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let _ : [MemberEntity] = [
            MemberEntity(name:"Muhammad Rifqi"),
            MemberEntity(name:"Muhammad Rifqi"),
            MemberEntity(name:"Muhammad Rifqi"),
            MemberEntity(name:"Muhammad Rifqi"),
            MemberEntity(name:"Muhammad Rifqi"),
            
        ]
        return AddPeopleViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct AddMemberViewController_PreviewProvider: PreviewProvider {
    static var previews: some View {
        AddMemberViewController_Preview()
            .edgesIgnoringSafeArea(.all)
    }
}




