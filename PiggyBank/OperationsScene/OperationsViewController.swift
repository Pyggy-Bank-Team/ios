import UIKit

final class OperationsViewController: UIViewController {
    
    private lazy var tableView = UITableView()
    private lazy var typeControl = UISegmentedControl()
    
    private var operations: [OperationViewModel] = []
    
    var presenter: OperationsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        typeControl.translatesAutoresizingMaskIntoConstraints = false
        typeControl.insertSegment(withTitle: "All", at: 0, animated: false)
        typeControl.insertSegment(withTitle: "Budget", at: 1, animated: false)
        typeControl.insertSegment(withTitle: "Transfer", at: 2, animated: false)
        typeControl.insertSegment(withTitle: "Plan", at: 3, animated: false)
        typeControl.selectedSegmentIndex = 0
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
        
        navigationItem.title = "Operations"
        
        presenter.onViewDidLoad()
    }
    
    func viewDidLoad(response: [OperationViewModel]) {
        operations = response
        tableView.reloadData()
    }
    
    func show(alert: String) {
        let alertController = UIAlertController(title: alert, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }

}

extension OperationsViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let operation = operations[indexPath.row]
        var actions: [UIContextualAction] = []
        
        let deleteAction = UIContextualAction(style: .normal, title: "") { [weak self] _, _, complete in
            self?.presenter.onDeleteOperation(id: operation.id)
            complete(true)
        }
        deleteAction.image = #imageLiteral(resourceName: "delete")
        actions.append(deleteAction)
        
        actions.forEach {
            $0.backgroundColor = .white
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: actions)
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension OperationsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let res = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            cell = res
        } else {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        }
        
        let operation = operations[indexPath.row]
        
        switch operation.type {
        case .budget:
            cell.textLabel?.text = "Budget"
            cell.imageView?.image = #imageLiteral(resourceName: "budget")
        case .plan:
            cell.textLabel?.text = "Plan"
            cell.imageView?.image = #imageLiteral(resourceName: "plan")
        case .transfer:
            cell.textLabel?.text = "Transfer"
            cell.imageView?.image = #imageLiteral(resourceName: "transfer")
        }
        
        return cell
    }
    
}
