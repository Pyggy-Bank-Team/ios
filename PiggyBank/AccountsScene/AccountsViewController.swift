import UIKit

final class AccountsViewController: UIViewController {
    
    private lazy var tableView = UITableView()
    
    private var accounts: [AccountsDTOs.ViewDidLoad.Response.Accounts.Account] = []
    
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
    
    func viewDidLoad(response: AccountsDTOs.ViewDidLoad.Response.Accounts) {
        accounts = response.accounts
        tableView.reloadData()
    }
    
    func onAdd(response: AccountsDTOs.OnAdd.Response) {
        let alertController = UIAlertController(title: response.title, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }

}

private extension AccountsViewController {
    
    @objc func onAdd(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter title"
        }
        
        let action = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            self.presenter.onAddAccount(request: .init(title: alertController?.textFields?.first?.text ?? ""))
        }
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
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
        
        if !account.isArchived {
            let archiveAction = UIContextualAction(style: .normal, title: "") { [weak self] _, _, complete in
                self?.presenter.onArchiveAccount(request: .init(index: indexPath.row))
                complete(true)
            }
            archiveAction.image = #imageLiteral(resourceName: "archive")
            actions.append(archiveAction)
        }
        
        let renameAction = UIContextualAction(style: .normal, title: "") { [weak self] _, _, complete in
            guard let self = self else { return }
            
            let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
            
            alertController.addTextField { textField in
                textField.placeholder = "Enter new title"
                textField.text = account.title
            }
            
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
                self.presenter.onRenameAccount(request: .init(index: indexPath.row, title: alertController?.textFields?.first?.text ?? ""))
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
            complete(true)
        }
        renameAction.image = #imageLiteral(resourceName: "rename")
        actions.append(renameAction)
        
        actions.forEach {
            $0.backgroundColor = .white
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: actions)
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        
        return swipeConfiguration
    }
    
}

extension AccountsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let account = accounts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            cell.textLabel?.text = account.title
            cell.detailTextLabel?.text = "\(account.total) \(account.currency)"
            
            if account.isArchived {
                cell.imageView?.image = #imageLiteral(resourceName: "archive")
            }
            
            return cell
        } else {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
            
            cell.textLabel?.text = account.title
            cell.detailTextLabel?.text = "\(account.total) \(account.currency)"
            
            if account.isArchived {
                cell.imageView?.image = #imageLiteral(resourceName: "archive")
            }
            
            
            return cell
        }
    }
    
}