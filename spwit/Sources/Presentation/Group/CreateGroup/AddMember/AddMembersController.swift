//
//  AddMemberController.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 04/08/25.
//

import UIKit

struct GroupingSection {
    let title: String
    let items: [String]
    var isExpanded: Bool
    var selectedIndices: Set<Int>
}

class AddMembersViewController: UIViewController, UITableViewDataSource, UITabBarDelegate, UITableViewDelegate {
    var presenter: AddMembersPresenter?
    
    var sections: [GroupingSection] = [
        GroupingSection(
            title: "People on Spwiwit",
            items: ["Adit Lucu", "Raiza Rawr", "Tyara UwU", "Syatria Ripki"],
            isExpanded: true,
            selectedIndices: []
        ),
    ]
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .darkBlue
        
        // Navigation Bar Setup
        title = "Add Members"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.darkBlue
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.lightGreen,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
        
        navigationController?.navigationBar.tintColor = UIColor.lightGreen
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        // Back button
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backTapped)
        )
        
        // Add button
        let rightBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(addTapped)
        )
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem

        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.textGrey
        ]
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search people", attributes: attributes)
        searchBar.searchTextField.leftView?.tintColor = .textGrey
        searchBar.searchTextField.backgroundColor = .transparantGrey
        searchBar.tintColor = .darkBlue
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .clear
        searchBar.searchTextField.textColor = .white
        view.addSubview(searchBar)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].isExpanded ? sections[section].items.count : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell") ?? UITableViewCell(style: .default, reuseIdentifier: "MemberCell")
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let item = sections[indexPath.section].items[indexPath.row]
        let isSelected = sections[indexPath.section].selectedIndices.contains(indexPath.row)
        let initialsBgColor: UIColor = isSelected ? .lightGreen : .grey
        let initialsTextColor: UIColor = isSelected ? .darkBlue : .black
        
        // --- Initials Circle ---
        let initials = item.split(separator: " ").compactMap { $0.first }.map { String($0) }.joined().uppercased()
        let initialCircle = InitialsCircleView(
            initials: initials,
            diameter: 44,
            bgColor: initialsBgColor,
            textColor: initialsTextColor,
            font: .systemFont(ofSize:18)
        )
        initialCircle.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(initialCircle)
        
        // --- Name Label ---
        let nameLabel = UILabel()
        nameLabel.text = item
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 18)
        nameLabel.textAlignment = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(nameLabel)
        
        // --- Radio/Checklist Icon ---
        let radioImage = UIImage(systemName: isSelected ? "checkmark.circle.fill" : "circle")
        let radio = UIImageView(image: radioImage)
        radio.tintColor = isSelected ? .lightGreen : .systemGray2
        radio.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(radio)
        
        NSLayoutConstraint.activate([
            initialCircle.widthAnchor.constraint(equalToConstant: 44),
            initialCircle.heightAnchor.constraint(equalToConstant: 44),
            initialCircle.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            initialCircle.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: initialCircle.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: radio.leadingAnchor, constant: -8),
            nameLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            
            radio.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            radio.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -18)
        ])
        
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIButton(type: .system)
        header.backgroundColor = .clear
        header.setTitle(sections[section].title, for: .normal)
        header.setTitleColor(.lightGreen, for: .normal)
        header.titleLabel?.font = Fonts.callout.bold
        header.contentHorizontalAlignment = .left
        header.tag = section
        header.addTarget(self, action: #selector(toggleSection(_:)), for: .touchUpInside)
        let arrow = UIImageView(image: UIImage(systemName: sections[section].isExpanded ? "chevron.down" : "chevron.right"))
        arrow.tintColor = .lightGreen
        arrow.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(arrow)
        NSLayoutConstraint.activate([
            arrow.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -12)
        ])
        return header
    }
    
    @objc func toggleSection(_ sender: UIButton) {
        let section = sender.tag
        sections[section].isExpanded.toggle()
        tableView.reloadSections([section], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if sections[indexPath.section].selectedIndices.contains(indexPath.row) {
            sections[indexPath.section].selectedIndices.remove(indexPath.row)
        } else {
            sections[indexPath.section].selectedIndices.insert(indexPath.row)
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    // MARK: - Navigation Actions
    
    @objc func backTapped() {
        presenter?.didBackTapped()
    }
    
    @objc func addTapped() {
        presenter?.didAddTapped()
    }
}
import SwiftUI
struct AddMembers_Preview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        AddMembersViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct AddMembers_PreviewProvider: PreviewProvider {
    static var previews: some View {
        AddMembers_Preview()
    }
}
