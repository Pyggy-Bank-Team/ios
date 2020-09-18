import UIKit

final class AccountsViewController: UIViewController {
    
    private lazy var tableView = UITableView()
    
    private var accounts: [AccountViewModel] = []
    
    var presenter: AccountsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = .zero
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        navigationItem.title = "Accounts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd(_:)))
        
        presenter.onViewDidLoad(request: .init())
    }
    
    func viewDidLoad(response: [AccountViewModel]) {
        accounts = response
        tableView.reloadData()
    }
    
    func onAdd(response: AccountsDTOs.OnAdd.Response) {
        let alertController = UIAlertController(title: response.title, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func onAdd(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func onSelect(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

}

private extension AccountsViewController {
    
    @objc func onAdd(_ sender: UIBarButtonItem) {
//        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
//
//        alertController.addTextField { textField in
//            textField.placeholder = "Enter title"
//        }
//
//        let action = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
//            self.presenter.onAddAccount(request: .init(title: alertController?.textFields?.first?.text ?? ""))
//        }
//
//        alertController.addAction(action)
//        present(alertController, animated: true, completion: nil)
        
        presenter.onAdd()
    }
    
}

extension AccountsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let account = accounts[indexPath.row]
        var actions: [UIContextualAction] = []
        
        
        let deleteAction = UIContextualAction(style: .normal, title: "") { [weak self] _, _, complete in
            self?.presenter.onDeleteAccount(request: .init(index: indexPath.row))
            complete(true)
        }
        deleteAction.image = #imageLiteral(resourceName: "delete")
        actions.append(deleteAction)
        
        
        let archiveAction = UIContextualAction(style: .normal, title: "") { [weak self] _, _, complete in
            self?.presenter.onArchiveAccount(request: .init(index: indexPath.row))
            complete(true)
        }
        archiveAction.image = account.isArchived ? #imageLiteral(resourceName: "unarchive") : #imageLiteral(resourceName: "archive")
        actions.append(archiveAction)
        
        actions.forEach {
            $0.backgroundColor = .white
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: actions)
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onSelect(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension AccountsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let account = accounts[indexPath.row]
        
        let cell: UITableViewCell
        if let res = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            cell = res
        } else {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        }
        
        var detailText = "\(account.balance)"
        
        if let currency = account.currency {
            detailText.append(" \(currency)")
        }
        
        cell.textLabel?.text = account.title
        cell.detailTextLabel?.text = detailText
        
        if account.isArchived {
            cell.imageView?.image = #imageLiteral(resourceName: "archive")
        }
        
        return cell
    }
    
}
