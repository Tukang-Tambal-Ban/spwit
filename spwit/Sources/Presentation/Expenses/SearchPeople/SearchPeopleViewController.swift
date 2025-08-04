import UIKit

class SearchPeopleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, SearchPeopleViewProtocol {
    var presenter: SearchPeoplePresenter?
    
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActivityIndicator()
        presenter?.fetchSuggestedUsers()
    }
    
    func setupUI() {
        view.backgroundColor = .darkBlue
        
        // --- Navigation Bar Setup ---
        title = "Search People"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.lightGreen,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
        navigationController?.navigationBar.tintColor = UIColor.lightGreen
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        // Back button
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backTapped)
        )
        navigationItem.leftBarButtonItem = backButton
        
        // Add button
        let addButton = UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(addTapped)
        )
        addButton.isEnabled = false
        navigationItem.rightBarButtonItem = addButton
        
        // --- Search Bar ---
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.textGrey
        ]
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search People", attributes: attributes)
        searchBar.searchTextField.leftView?.tintColor = .textGrey
        searchBar.searchTextField.backgroundColor = .transparantGrey
        searchBar.tintColor = .darkBlue
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .clear
        searchBar.searchTextField.textColor = .white
        view.addSubview(searchBar)
        
        // --- TableView ---
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
    
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - TableView DataSource & Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If there's a search query, show searchedUsers, otherwise suggestedUsers
        let searchText = searchBar.text ?? ""
        return (searchText.isEmpty ? presenter?.suggestedUsers.count : presenter?.searchedUsers.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell") ?? UITableViewCell(style: .default, reuseIdentifier: "MemberCell")
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let users = (searchBar.text?.isEmpty ?? true) ? presenter?.suggestedUsers : presenter?.searchedUsers
        let user = users?[indexPath.row]
        let item = user?.username ?? ""
        let isSelected = presenter?.selectedUsers.contains(where: { $0.id == user?.id }) ?? false
        let initialsBgColor: UIColor = isSelected ? .lightGreen : .grey
        let initialsTextColor: UIColor = isSelected ? .darkBlue : .black
        
        // --- Initials Circle ---
        let initials = item.split(separator: " ").compactMap { $0.first }.map { String($0) }.joined().uppercased()
        let initialCircle = InitialsCircleView(
            initials: initials,
            diameter: 44,
            bgColor: initialsBgColor,
            textColor: initialsTextColor,
            font: .preferredFont(forTextStyle: .body)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let users = (searchBar.text?.isEmpty ?? true) ? presenter?.suggestedUsers : presenter?.searchedUsers
        if let user = users?[indexPath.row] {
            presenter?.toggleSelectedUser(with: user)
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    // MARK: - SearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, !text.isEmpty {
            presenter?.searchUsers(query: text)
        } else {
            presenter?.fetchSuggestedUsers()
        }
    }
    
    // MARK: - Navigation Actions
    
    @objc func backTapped() {
        presenter?.didBackTapped()
    }
    
    @objc func addTapped() {
        presenter?.didAddTapped()
    }
    
    // MARK: - SearchPeopleViewProtocol
    func showSuggestedUsers(_ users: [User]) {
        tableView.reloadData()
    }
    
    func showSearchUsers(_ users: [User]) {
        tableView.reloadData()
    }
    
    func showSelectedUsers(_ users: [User]) {
        navigationItem.rightBarButtonItem?.isEnabled = !users.isEmpty
    }
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
}
