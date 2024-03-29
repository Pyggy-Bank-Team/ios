import UIKit

class ProfileViewController: UIViewController {
    
    var presenter: ProfilePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Sign out",
            style: .plain,
            target: self,
            action: #selector(onSignOut(_:))
        )
        
        view.backgroundColor = .white

        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        navigationItem.title = "Menu"
        navigationItem.backButtonTitle = ""
        navigationItem.hidesBackButton = true
    }
    
    func onSignOut() {
        navigationController?.popViewController(animated: true)
    }

}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(DependencyProvider.shared.get(screen: .accounts), animated: true)
        case 1:
            navigationController?.pushViewController(DependencyProvider.shared.get(screen: .categories), animated: true)
        case 2:
            navigationController?.pushViewController(DependencyProvider.shared.get(screen: .operations), animated: true)
        case 3:
            navigationController?.pushViewController(DependencyProvider.shared.get(screen: .reports), animated: true)
        default:
            break
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Accounts"
        case 1:
            cell.textLabel?.text = "Categories"
        case 2:
            cell.textLabel?.text = "Operations"
        case 3:
            cell.textLabel?.text = "Reports"
        default:
            break
        }
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
}

private extension ProfileViewController {
    
    @objc
    func onSignOut(_ sender: UIBarButtonItem) {
        presenter.onSignOut()
    }
    
}
