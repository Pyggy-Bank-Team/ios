import UIKit

final class BaseCurrencyViewController: UIViewController {
    
    private lazy var tableView = UITableView(frame: .zero, style: .grouped)
    
    private var currencies: [CurrencyViewModel] = []
    
    var presenter: BaseCurrencyPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Choose base currency"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDone(_:)))
        
        view.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        tableView.register(CurrencyTableCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
        
        presenter.loadCurrencies()
    }
    
    func loadCurrencies(currencies: [CurrencyViewModel]) {
        self.currencies = currencies
        tableView.reloadData()
    }

}

extension BaseCurrencyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for (index, _) in currencies.enumerated() where index != indexPath.row {
            tableView.cellForRow(at: IndexPath(row: index, section: 0))?.accessoryType = .none
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
}

extension BaseCurrencyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currency = currencies[indexPath.row]
        
        cell.textLabel?.text = "\(currency.code) - \(currency.symbol)"
        
        return cell
    }
    
}

private extension BaseCurrencyViewController {
    
    @objc func onDone(_ sender: UIBarButtonItem) {
        
    }
    
}
