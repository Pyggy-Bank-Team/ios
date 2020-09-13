import UIKit

final class AccountViewController: UIViewController {
    
    private var accountViewModel: AccountViewModel?
    
    private lazy var typeControl = UISegmentedControl()
    private lazy var titleField = UITextField()
    private lazy var balanceField = UITextField()
    private lazy var deleteButton = UIButton(type: .system)
    private lazy var deleteBorderView = UIView()
    
    var presenter: AccountPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onSave(_:)))

        view.backgroundColor = .white
        
        typeControl.insertSegment(withTitle: "Cash", at: 0, animated: true)
        typeControl.insertSegment(withTitle: "Card", at: 1, animated: true)
        typeControl.translatesAutoresizingMaskIntoConstraints = false
        
        titleField.placeholder = "Title"
        titleField.textAlignment = .center
        titleField.translatesAutoresizingMaskIntoConstraints = false
        
        balanceField.placeholder = "Balance"
        balanceField.textAlignment = .center
        balanceField.translatesAutoresizingMaskIntoConstraints = false
        
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        deleteBorderView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1991362236)
        deleteBorderView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(typeControl)
        view.addSubview(titleField)
        view.addSubview(balanceField)
        view.addSubview(deleteButton)
        view.addSubview(deleteBorderView)
        
        NSLayoutConstraint.activate([
            typeControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            typeControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            typeControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleField.topAnchor.constraint(equalTo: typeControl.bottomAnchor, constant: 50),
            titleField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            titleField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            balanceField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 50),
            balanceField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            balanceField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            deleteBorderView.widthAnchor.constraint(equalTo: deleteButton.widthAnchor),
            deleteBorderView.heightAnchor.constraint(equalToConstant: 0.5),
            deleteBorderView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor),
            
            deleteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        presenter.loadAccount()
    }
    
    func loadAccount(account: AccountViewModel?) {
        accountViewModel = account
        
        if let account = account {
            navigationItem.title = account.title
            typeControl.selectedSegmentIndex = account.type.rawValue
            titleField.text = account.title
            balanceField.text = account.balance.description
        } else {
            navigationItem.title = "New Account"
            typeControl.selectedSegmentIndex = 0
            deleteBorderView.isHidden = true
            deleteButton.isHidden = true
        }
    }

}

private extension AccountViewController {
    
    @objc func onSave(_ sender: UIBarButtonItem) {
        
    }
    
}
