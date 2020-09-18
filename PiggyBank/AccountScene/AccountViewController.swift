import UIKit

final class AccountViewController: UIViewController {
    
    private var accountViewModel: AccountViewModel?
    
    private lazy var scrollView = UIScrollView()
    private lazy var typeControl = UISegmentedControl()
    private lazy var titleField = UITextField()
    private lazy var titleBorderView = UIView()
    private lazy var balanceField = UITextField()
    private lazy var balanceBorderView = UIView()
    private lazy var archivedLabel = UILabel()
    private lazy var archiveSwitch = UISwitch()
    private lazy var deleteButton = UIButton(type: .system)
    private lazy var deleteBorderView = UIView()
    
    var presenter: AccountPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onSave(_:)))

        view.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .onDrag
        
        typeControl.insertSegment(withTitle: "Cash", at: 0, animated: false)
        typeControl.insertSegment(withTitle: "Card", at: 1, animated: false)
        typeControl.translatesAutoresizingMaskIntoConstraints = false
        
        titleField.placeholder = "Title"
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.returnKeyType = .continue
        titleField.delegate = self
        titleField.addTarget(self, action: #selector(onChangeTitle(_:)), for: .editingChanged)
        titleField.autocorrectionType = .no
        
        titleBorderView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1991362236)
        titleBorderView.translatesAutoresizingMaskIntoConstraints = false
        
        balanceField.placeholder = "Balance"
        balanceField.translatesAutoresizingMaskIntoConstraints = false
        balanceField.keyboardType = .numberPad
        
        balanceBorderView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1991362236)
        balanceBorderView.translatesAutoresizingMaskIntoConstraints = false
        
        archivedLabel.text = "Archived"
        archivedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        archiveSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addTarget(self, action: #selector(onDelete(_:)), for: .touchUpInside)
        
        deleteBorderView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1991362236)
        deleteBorderView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(typeControl)
        scrollView.addSubview(titleField)
        scrollView.addSubview(titleBorderView)
        scrollView.addSubview(balanceField)
        scrollView.addSubview(balanceBorderView)
        scrollView.addSubview(archivedLabel)
        scrollView.addSubview(archiveSwitch)
        scrollView.addSubview(deleteButton)
        scrollView.addSubview(deleteBorderView)
        
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            typeControl.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25),
            typeControl.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8),
            typeControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            titleField.topAnchor.constraint(equalTo: typeControl.bottomAnchor, constant: 40),
            titleField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8),
            titleField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            titleBorderView.widthAnchor.constraint(equalTo: titleField.widthAnchor),
            titleBorderView.heightAnchor.constraint(equalToConstant: 0.5),
            titleBorderView.topAnchor.constraint(equalTo: titleField.bottomAnchor),
            titleBorderView.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            
            balanceField.topAnchor.constraint(equalTo: titleBorderView.bottomAnchor, constant: 30),
            balanceField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8),
            balanceField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            balanceBorderView.widthAnchor.constraint(equalTo: balanceField.widthAnchor),
            balanceBorderView.heightAnchor.constraint(equalToConstant: 0.5),
            balanceBorderView.topAnchor.constraint(equalTo: balanceField.bottomAnchor),
            balanceBorderView.leadingAnchor.constraint(equalTo: balanceField.leadingAnchor),
            
            archivedLabel.widthAnchor.constraint(equalTo: balanceBorderView.widthAnchor, multiplier: 0.6),
            archivedLabel.topAnchor.constraint(equalTo: balanceBorderView.bottomAnchor, constant: 30),
            archivedLabel.leadingAnchor.constraint(equalTo: balanceBorderView.leadingAnchor),
            
            archiveSwitch.centerYAnchor.constraint(equalTo: archivedLabel.centerYAnchor),
            archiveSwitch.trailingAnchor.constraint(equalTo: balanceBorderView.trailingAnchor),
            
            deleteBorderView.widthAnchor.constraint(equalTo: deleteButton.widthAnchor),
            deleteBorderView.heightAnchor.constraint(equalToConstant: 0.5),
            deleteBorderView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor),
            
            deleteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        presenter.loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: 800)
    }
    
    func loadAccount(account: AccountViewModel?) {
        accountViewModel = account
        
        if let account = account {
            navigationItem.title = "\(account.title) • \(account.currency!)"
            typeControl.selectedSegmentIndex = account.type.rawValue
            titleField.text = account.title
            balanceField.text = account.balance.description
            archiveSwitch.isOn = account.isArchived
        } else {
            navigationItem.title = "New Account"
            typeControl.selectedSegmentIndex = 0
            deleteBorderView.isHidden = true
            deleteButton.isHidden = true
            titleField.becomeFirstResponder()
            archiveSwitch.isOn = false
        }
    }
    
    func accountSaved() {
        let alertController = UIAlertController(title: "Account saved", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func accountDeleted() {
        let alertController = UIAlertController(title: "Account deleted", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }

}

private extension AccountViewController {
    
    @objc func onSave(_ sender: UIBarButtonItem) {
        presenter.onSave()
    }
    
    @objc func onChangeTitle(_ sender: UITextField) {
        updateNavigationTitle()
    }
    
    @objc func onDelete(_ sender: UIButton) {
        presenter.onDelete()
    }
    
}

extension AccountViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField == titleField else { return true }
        
        titleField.resignFirstResponder()
        balanceField.becomeFirstResponder()
        
        return true
    }
    
}

extension AccountViewController {
    
    var accountType: Int {
        return typeControl.selectedSegmentIndex
    }
    
    var accountTitle: String {
        return titleField.text ?? ""
    }
    
    var accountBalance: Double {
        return Double(balanceField.text ?? "") ?? 0.0
    }
    
    var accountArchived: Bool {
        return archiveSwitch.isOn
    }
    
}

private extension AccountViewController {
    
    func updateNavigationTitle() {
        let accountTitle = titleField.text ?? ""
        let currency = accountViewModel?.currency ?? "Base"
        
        navigationItem.title = "\(accountTitle) • \(currency)"
    }
    
}
