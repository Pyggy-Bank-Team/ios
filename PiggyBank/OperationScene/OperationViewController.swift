import UIKit

class OperationViewController: UIViewController {
    
    var presenter: OperationPresenter!

    var items: [String] = ["СБЕР Банк", "Карта Тинькофф", "Заначка под подушкой", "Счет на Кипре", "СБЕР Банк", "Карта Тинькофф", "Заначка под подушкой", "Счет на Кипре"]
    
    private lazy var backButton = UIButton(type: .system)
    private lazy var headerLabel = UILabel()
    private lazy var totalField = UITextField()
    private lazy var totalBorder = UIView()
    private lazy var operationTypeControl = UISegmentedControl()
    private lazy var dateLabel = UILabel()
    private lazy var datePicker = UIDatePicker()
    private lazy var fromLabel = UILabel()
    private lazy var categoriesFlexView = FlexView()

    private var categoriesHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        
        backButton.setImage(#imageLiteral(resourceName: "arrow-left"), for: .normal)
        backButton.addTarget(self, action: #selector(onBack(_:)), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.tintColor = .black
        backButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.addSubview(backButton)
        
        headerLabel.text = "Add new operation"
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        headerLabel.font = .boldSystemFont(ofSize: 17)
        view.addSubview(headerLabel)
        
        totalField.placeholder = "Enter total.."
        totalField.font = .systemFont(ofSize: 25)
        totalField.tintColor = .green
        totalField.textColor = .green
        totalField.translatesAutoresizingMaskIntoConstraints = false
        totalField.keyboardType = .numberPad
        view.addSubview(totalField)

        totalBorder.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        totalBorder.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalBorder)

        operationTypeControl.insertSegment(withTitle: "Outcome", at: 0, animated: false)
        operationTypeControl.insertSegment(withTitle: "Income", at: 1, animated: false)
        operationTypeControl.insertSegment(withTitle: "Transfer", at: 2, animated: false)
        operationTypeControl.selectedSegmentIndex = 0
        if #available(iOS 13.0, *) {
            operationTypeControl.selectedSegmentTintColor = .systemBlue
            operationTypeControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        }
        operationTypeControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(operationTypeControl)

        dateLabel.text = "Date"
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)

        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .compact
        }
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.date = Date()
        view.addSubview(datePicker)

        fromLabel.text = "From"
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fromLabel)

        categoriesFlexView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoriesFlexView)

        categoriesHeightConstraint = categoriesFlexView.heightAnchor.constraint(equalToConstant: 15)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            headerLabel.centerYAnchor.constraint(equalTo: backButton.safeAreaLayoutGuide.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: backButton.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            totalField.topAnchor.constraint(equalTo: headerLabel.safeAreaLayoutGuide.bottomAnchor, constant: 30),
            totalField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            totalField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),

            totalBorder.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            totalBorder.widthAnchor.constraint(equalTo: totalField.safeAreaLayoutGuide.widthAnchor),
            totalBorder.topAnchor.constraint(equalTo: totalField.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            totalBorder.heightAnchor.constraint(equalToConstant: 1),

            operationTypeControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            operationTypeControl.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
            operationTypeControl.topAnchor.constraint(equalTo: totalBorder.safeAreaLayoutGuide.bottomAnchor, constant: 20),

            dateLabel.leadingAnchor.constraint(equalTo: totalBorder.safeAreaLayoutGuide.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: operationTypeControl.safeAreaLayoutGuide.bottomAnchor, constant: 50),

            datePicker.leadingAnchor.constraint(equalTo: dateLabel.safeAreaLayoutGuide.leadingAnchor),
            datePicker.topAnchor.constraint(equalTo: dateLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),

            fromLabel.leadingAnchor.constraint(equalTo: dateLabel.safeAreaLayoutGuide.leadingAnchor),
            fromLabel.topAnchor.constraint(equalTo: datePicker.safeAreaLayoutGuide.bottomAnchor, constant: 50),

            categoriesFlexView.leadingAnchor.constraint(equalTo: dateLabel.safeAreaLayoutGuide.leadingAnchor),
            categoriesFlexView.topAnchor.constraint(equalTo: fromLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            categoriesFlexView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            categoriesHeightConstraint,
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let height = categoriesFlexView.update(with: items)

        view.layoutIfNeeded()

        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.categoriesHeightConstraint.constant = height
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.categoriesFlexView.updateViews()
            })
    }
}

private extension OperationViewController {
    
    @objc func onBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
