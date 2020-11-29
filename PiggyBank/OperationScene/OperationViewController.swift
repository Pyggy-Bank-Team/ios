import UIKit

class OperationViewController: UIViewController {
    
    var presenter: OperationPresenter!
    
    private lazy var backButton = UIButton(type: .system)
    private lazy var headerLabel = UILabel()
    private lazy var totalField = UITextField()
    private lazy var totalBorder = UIView()
    private lazy var operationTypeControl = UISegmentedControl()
    private lazy var dateLabel = UILabel()
    private lazy var datePicker = UIDatePicker()
    private lazy var fromLabel = UILabel()
    private lazy var fromCategoriesFlexView = FlexView()
    private lazy var toLabel = UILabel()
    private lazy var toCategoriesFlexView = FlexView()
    private lazy var createButton = UIButton(type: .system)

    private var fromCategoriesHeightConstraint: NSLayoutConstraint!
    private var toCategoriesHeightConstraint: NSLayoutConstraint!

    private var selectedFrom: Int?
    private var selectedTo: Int?

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

        fromCategoriesFlexView.translatesAutoresizingMaskIntoConstraints = false
        fromCategoriesHeightConstraint = fromCategoriesFlexView.heightAnchor.constraint(equalToConstant: 15)
        fromCategoriesFlexView.delegate = self
        view.addSubview(fromCategoriesFlexView)

        toLabel.text = "To"
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toLabel)

        toCategoriesFlexView.translatesAutoresizingMaskIntoConstraints = false
        toCategoriesHeightConstraint = toCategoriesFlexView.heightAnchor.constraint(equalToConstant: 15)
        toCategoriesFlexView.delegate = self
        view.addSubview(toCategoriesFlexView)

        createButton.setTitle("OK", for: .normal)
        createButton.setTitleColor(.white, for: .normal)
        createButton.backgroundColor = .systemBlue
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.layer.cornerRadius = 20
        createButton.addTarget(self, action: #selector(onCreate(_:)), for: .touchUpInside)
        view.addSubview(createButton)
        
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

            fromCategoriesFlexView.leadingAnchor.constraint(equalTo: dateLabel.safeAreaLayoutGuide.leadingAnchor),
            fromCategoriesFlexView.topAnchor.constraint(equalTo: fromLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            fromCategoriesFlexView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            fromCategoriesHeightConstraint,

            toLabel.leadingAnchor.constraint(equalTo: dateLabel.safeAreaLayoutGuide.leadingAnchor),
            toLabel.topAnchor.constraint(equalTo: fromCategoriesFlexView.safeAreaLayoutGuide.bottomAnchor, constant: 50),

            toCategoriesFlexView.leadingAnchor.constraint(equalTo: dateLabel.safeAreaLayoutGuide.leadingAnchor),
            toCategoriesFlexView.topAnchor.constraint(equalTo: toLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            toCategoriesFlexView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            toCategoriesHeightConstraint,

            createButton.leadingAnchor.constraint(equalTo: dateLabel.safeAreaLayoutGuide.leadingAnchor),
            createButton.topAnchor.constraint(equalTo: toCategoriesFlexView.safeAreaLayoutGuide.bottomAnchor, constant: 50),
            createButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            createButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        presenter.onViewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    func show(alert: String) {
        let alertController = UIAlertController(title: alert, message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)

        present(alertController, animated: true, completion: nil)
    }
}

extension OperationViewController {

    func itemsLoaded(items: [String]) {
        let fromHeight = fromCategoriesFlexView.update(with: items)
        let toHeight = toCategoriesFlexView.update(with: items)

        view.layoutIfNeeded()

        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.fromCategoriesHeightConstraint.constant = fromHeight
                self.toCategoriesHeightConstraint.constant = toHeight
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.fromCategoriesFlexView.updateViews()
                self.toCategoriesFlexView.updateViews()
            })
    }

    var sourceAccount: Int {
        return selectedFrom ?? 0
    }

    var targetAccount: Int {
        return selectedTo ?? 0
    }

    var transferDate: Date {
        return datePicker.date
    }

    var total: Int {
        return Int(totalField.text ?? "") ?? 0
    }
}

extension OperationViewController: FlexViewDelegate {

    func flexView(_ flexView: FlexView, didSelectRowAt index: Int) {
        if flexView == fromCategoriesFlexView {
            selectedFrom = index
        }

        if flexView == toCategoriesFlexView {
            selectedTo = index
        }

        print("\(selectedFrom ?? 0) -> \(selectedTo ?? 0)")
    }
}

private extension OperationViewController {
    
    @objc func onBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @objc func onCreate(_ sender: UIButton) {
        presenter.onCreate()
    }
}
