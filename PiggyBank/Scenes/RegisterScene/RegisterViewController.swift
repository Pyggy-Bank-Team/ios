//
//  RegisterViewController.swift
//  PiggyBank
//

import UIKit

class RegisterViewController: UIViewController, UIGestureRecognizerDelegate {

    var presenter: RegisterPresenter!

    private let passwordMinimunChars = 6

    private lazy var usernameTextField: PiggyTextField = {
        let usernameTextField = PiggyTextField(type: .text)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        let placeholderText = NSAttributedString(string: "Username",
                                                 attributes: [.foregroundColor: UIColor(hexString: "#A0A3BD")])
        usernameTextField.attributedPlaceholder = placeholderText
        usernameTextField.addTarget(self, action: #selector(onTextFieldChanged), for: .editingChanged)
        return usernameTextField
    }()

    private lazy var emailTextField: PiggyTextField = {
        let usernameTextField = PiggyTextField(type: .text)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        let placeholderText = NSAttributedString(string: "Email",
                                                 attributes: [.foregroundColor: UIColor(hexString: "#A0A3BD")])
        usernameTextField.attributedPlaceholder = placeholderText
        usernameTextField.addTarget(self, action: #selector(onTextFieldChanged), for: .editingChanged)
        return usernameTextField
    }()

    private lazy var passwordTextField: PiggyTextField = {
        let passwordTextField = PiggyTextField(type: .password)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        let placeholderText = NSAttributedString(string: "Password",
                                                 attributes: [.foregroundColor: UIColor(hexString: "#A0A3BD")])
        passwordTextField.attributedPlaceholder = placeholderText
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(self, action: #selector(onTextFieldChanged), for: .editingChanged)
        return passwordTextField
    }()

    private lazy var lengthWarning: UILabel = {
        let digitSymbolWarning = UILabel()
        digitSymbolWarning.translatesAutoresizingMaskIntoConstraints = false
        digitSymbolWarning.text = "Must have at least \(passwordMinimunChars) characters"
        digitSymbolWarning.font = .systemFont(ofSize: 14.0, weight: .regular)
        digitSymbolWarning.textColor = UIColor.piggy.red
        return digitSymbolWarning
    }()

    private lazy var digitSymbolWarning: UILabel = {
        let digitSymbolWarning = UILabel()
        digitSymbolWarning.translatesAutoresizingMaskIntoConstraints = false
        digitSymbolWarning.text = "Must have digit character"
        digitSymbolWarning.font = .systemFont(ofSize: 14.0, weight: .regular)
        digitSymbolWarning.textColor = UIColor.piggy.red
        return digitSymbolWarning
    }()

    private lazy var upperCaseSymbolWarning: UILabel = {
        let upperCaseSymbolWarning = UILabel()
        upperCaseSymbolWarning.translatesAutoresizingMaskIntoConstraints = false
        upperCaseSymbolWarning.text = "Must have uppercased letter"
        upperCaseSymbolWarning.font = .systemFont(ofSize: 14.0, weight: .regular)
        upperCaseSymbolWarning.textColor = UIColor.piggy.red
        return upperCaseSymbolWarning
    }()

    private lazy var lowerCaseSymbolWarning: UILabel = {
        let upperCaseSymbolWarning = UILabel()
        upperCaseSymbolWarning.translatesAutoresizingMaskIntoConstraints = false
        upperCaseSymbolWarning.text = "Must have lowercased letter"
        upperCaseSymbolWarning.font = .systemFont(ofSize: 14.0, weight: .regular)
        upperCaseSymbolWarning.textColor = UIColor.piggy.red
        return upperCaseSymbolWarning
    }()

    private lazy var specialSymbolWarning: UILabel = {
        let specialSymbolWarning = UILabel()
        specialSymbolWarning.translatesAutoresizingMaskIntoConstraints = false
        specialSymbolWarning.text = "Must have non-alphanumeric character"
        specialSymbolWarning.font = .systemFont(ofSize: 14.0, weight: .regular)
        specialSymbolWarning.textColor = UIColor.piggy.red
        return specialSymbolWarning
    }()

    private lazy var passwordRequirementsStackView: UIStackView = {
        let passwordRequirements = UIStackView(arrangedSubviews: [
            lengthWarning,
            digitSymbolWarning,
            upperCaseSymbolWarning,
            lowerCaseSymbolWarning,
            specialSymbolWarning
        ])
        passwordRequirements.translatesAutoresizingMaskIntoConstraints = false
        passwordRequirements.axis = .vertical
        return passwordRequirements
    }()

    private lazy var currencyView: ContentBlockView = {
        let currencyView = ContentBlockView()
        currencyView.translatesAutoresizingMaskIntoConstraints = false
        currencyView.build(title: "Main Currency", value: "...")
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onCurrencyPressed))
        currencyView.addGestureRecognizer(gestureRecognizer)
        return currencyView
    }()

    private var bottomRegisterConstraint: NSLayoutConstraint!
    private lazy var registerButton: PrimaryButton = {
        let registerButton = PrimaryButton()
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Register", for: .normal)
        registerButton.addTarget(self, action: #selector(onRegisterPressed), for: .touchUpInside)
        registerButton.isEnabled = false
        return registerButton
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: false)
        configureNavigationBar(backgoundColor: .white,
                               tintColor: .black,
                               title: "Registration",
                               preferredLargeTitle: false)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

        view.backgroundColor = .white

        confugreLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadCurrencies()
    }

    private func confugreLayout() {
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(passwordRequirementsStackView)
        view.addSubview(currencyView)
        view.addSubview(registerButton)
        view.addSubview(activityIndicator)

        bottomRegisterConstraint = registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                                          constant: -20.0)
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.0),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.0),

            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30.0),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.0),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.0),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30.0),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.0),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.0),

            passwordRequirementsStackView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10.0),
            passwordRequirementsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.0),
            passwordRequirementsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.0),

            currencyView.topAnchor.constraint(equalTo: passwordRequirementsStackView.bottomAnchor, constant: 20.0),
            currencyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.0),
            currencyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.0),

            registerButton.heightAnchor.constraint(equalToConstant: 47.0),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.0),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.0),
            bottomRegisterConstraint,

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc
    private func popToPrevious() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    private func onCurrencyPressed() {
        presenter.showChangeCurrencyScreen()
    }

    @objc
    private func onRegisterPressed() {
        activityIndicator.startAnimating()
        presenter.onRegisterPressed(nickname: usernameTextField.text ?? "",
                                    email: emailTextField.text ?? "",
                                    password: passwordTextField.text ?? "")
    }

    @objc
    private func onTextFieldChanged() {
        let isUsernameTextFieldEmpty = usernameTextField.text?.isEmpty ?? true
        let isPasswordTextFieldEmpty = passwordTextField.text?.isEmpty ?? true
        let isEmailTextFieldEmpty = emailTextField.text?.isEmpty ?? true
        let isValidPwd = isValidPassword(password: passwordTextField.text)
        registerButton.isEnabled = isValidPwd && !isUsernameTextFieldEmpty && !isPasswordTextFieldEmpty && !isEmailTextFieldEmpty
    }

    @objc
    private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let keyboardHeight = keyboardSize.height
        self.bottomRegisterConstraint.constant = view.safeAreaInsets.bottom - keyboardHeight - 20
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

    @objc
    private func keyboardWillHide(notification: Notification) {
        self.bottomRegisterConstraint.constant = -20
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}

extension RegisterViewController {

    func loadCurrency(currency: String) {
        currencyView.valueLabel.text = currency
    }

    func onRegistrationError(error: String) {
        activityIndicator.stopAnimating()

        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

private extension RegisterViewController {

    func isValidPassword(password: String?) -> Bool {
        guard let password = password else {
            digitSymbolWarning.textColor = UIColor.piggy.red
            upperCaseSymbolWarning.textColor = UIColor.piggy.red
            lowerCaseSymbolWarning.textColor = UIColor.piggy.red
            specialSymbolWarning.textColor = UIColor.piggy.red
            lengthWarning.textColor = UIColor.piggy.red
            return false
        }

        let hasDecimalDigits = password.rangeOfCharacter(from: .decimalDigits) != nil
        digitSymbolWarning.textColor = hasDecimalDigits ? UIColor.piggy.green : UIColor.piggy.red

        let hasUppercaseLetters = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        upperCaseSymbolWarning.textColor = hasUppercaseLetters ? UIColor.piggy.green : UIColor.piggy.red

        let hasLowercaseLetters = password.rangeOfCharacter(from: .lowercaseLetters) != nil
        lowerCaseSymbolWarning.textColor = hasLowercaseLetters ? UIColor.piggy.green : UIColor.piggy.red

        let hasSpecialSymbols = password.rangeOfCharacter(from: .punctuationCharacters) != nil
            || password.rangeOfCharacter(from: .symbols) != nil
        specialSymbolWarning.textColor = hasSpecialSymbols ? UIColor.piggy.green : UIColor.piggy.red

        let hasValidLength = password.count >= passwordMinimunChars
        lengthWarning.textColor = hasValidLength ? UIColor.piggy.green : UIColor.piggy.red

        return hasDecimalDigits && hasUppercaseLetters && hasLowercaseLetters && hasSpecialSymbols && hasValidLength
    }

}
