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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd(_:)))
        
        presenter.onViewDidLoad(request: .init())
    }
    
    func viewDidLoad(response: AccountsDTOs.ViewDidLoad.Response.Title) {
        navigationItem.title = response.title
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
    
    
    
}

extension AccountsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let account = accounts[indexPath.row]
        
        cell.textLabel?.text = account.title
        cell.textLabel?.textColor = account.isArchived ? .red : .green
        
        return cell
    }
    
}
