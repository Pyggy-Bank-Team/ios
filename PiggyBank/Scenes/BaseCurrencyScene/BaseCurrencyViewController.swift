import UIKit

final class BaseCurrencyViewController: UIViewController {

    private lazy var tableView = UITableView(frame: .zero, style: .grouped)
    
    private var currencies: [CurrencyViewModel] = []
    
    var presenter: BaseCurrencyPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Choose Currency"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDone(_:)))

        view.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        tableView.register(CurrencyTableCell.self, forCellReuseIdentifier: "CurrencyTableCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        presenter.loadCurrencies()
    }

    func loadCurrencies(currencies: [CurrencyViewModel], initialIndex: Int) {
        self.currencies = currencies
        tableView.reloadData()
        tableView.cellForRow(at: IndexPath(row: initialIndex, section: 0))?.accessoryType = .checkmark
    }

    func onDone(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

}

extension BaseCurrencyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for index in currencies.indices where index != indexPath.row {
            tableView.cellForRow(at: IndexPath(row: index, section: 0))?.accessoryType = .none
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
}

extension BaseCurrencyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableCell", for: indexPath)
        let currency = currencies[indexPath.row]
        cell.textLabel?.text = "\(Locale.current.localizedString(forCurrencyCode: currency.code) ?? "") (\(currency.symbol))"
        return cell
    }

}

private extension BaseCurrencyViewController {
    
    @objc
    func onDone(_ sender: UIBarButtonItem) {
        presenter.onDone(index: tableView.indexPathForSelectedRow?.row ?? IndexPath(row: 0, section: 0).row)
    }

}
