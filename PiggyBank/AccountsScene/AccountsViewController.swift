import UIKit

final class AccountsViewController: UIViewController {
    
    private lazy var tableView = UITableView()
    private lazy var typeControl = UISegmentedControl()
    
    private var allAccounts: [AccountViewModel] = []
    private var cashAccounts: [AccountViewModel] = []
    private var cardAccounts: [AccountViewModel] = []
    
    var presenter: AccountsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        typeControl.translatesAutoresizingMaskIntoConstraints = false
        typeControl.addTarget(self, action: #selector(onChangeType(_:)), for: .valueChanged)
        view.addSubview(typeControl)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = .zero
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            typeControl.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            typeControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            typeControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: typeControl.safeAreaLayoutGuide.bottomAnchor, constant: 20)
        ])
        
        navigationItem.title = "Accounts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd(_:)))
        
        presenter.onViewDidLoad(request: .init())
    }
    
    func viewDidLoad(response: [AccountViewModel]) {
        allAccounts = response
        
        for account in allAccounts {
            if account.type == .cash {
                cashAccounts.append(account)
            } else {
                cardAccounts.append(account)
            }
        }
        
        typeControl.insertSegment(withTitle: "All", at: 0, animated: false)
        
        var indexToInsert = 1
        if !cashAccounts.isEmpty {
            typeControl.insertSegment(withTitle: "Cash", at: indexToInsert, animated: false)
            indexToInsert += 1
        }
        
        if !cardAccounts.isEmpty {
            typeControl.insertSegment(withTitle: "Card", at: indexToInsert, animated: false)
        }
        
        typeControl.selectedSegmentIndex = 0
        
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
        presenter.onAdd()
    }
    
    @objc func onChangeType(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    func element(at indexPath: IndexPath) -> AccountViewModel {
        let selected = typeControl.selectedSegmentIndex
        
        if selected == 0 {
            return allAccounts[indexPath.row]
        } else if selected == 1 && !cashAccounts.isEmpty {
            return cashAccounts[indexPath.row]
        } else {
            return cardAccounts[indexPath.row]
        }
    }
    
}

extension AccountsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let account = element(at: indexPath)
        var actions: [UIContextualAction] = []
        
        
        let deleteAction = UIContextualAction(style: .normal, title: "") { [weak self] _, _, complete in
            self?.presenter.onDeleteAccount(id: account.id)
            complete(true)
        }
        deleteAction.image = #imageLiteral(resourceName: "delete")
        actions.append(deleteAction)
        
        
        let archiveAction = UIContextualAction(style: .normal, title: "") { [weak self] _, _, complete in
            self?.presenter.onArchiveAccount(id: account.id)
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
        let account = element(at: indexPath)
        presenter.onSelect(id: account.id)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension AccountsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard typeControl.selectedSegmentIndex >= 0 else { return 0 }
        
        let selected = typeControl.selectedSegmentIndex
        
        if selected == 0 {
            return allAccounts.count
        } else if selected == 1 && !cashAccounts.isEmpty {
            return cashAccounts.count
        } else {
            return cardAccounts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let account = element(at: indexPath)
        
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
        } else {
            cell.imageView?.image = nil
        }
        
        return cell
    }
    
}
