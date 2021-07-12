//
//  LoginViewController.swift
//  PiggyBank
//

import UIKit

class LoginViewController: UIViewController, UIGestureRecognizerDelegate {

    var presenter: LoginPresenter!

    private lazy var usernameTextField: PiggyTextField = {
        let usernameTextField = PiggyTextField(type: .text)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        let placeholderText = NSAttributedString(string: "Username",
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

    private var bottomLoginConstraint: NSLayoutConstraint!
    private lazy var loginButton: PrimaryButton = {
        let registerButton = PrimaryButton()
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Login", for: .normal)
        registerButton.addTarget(self, action: #selector(onLoginPressed), for: .touchUpInside)
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
        configureNavigationBar(backgoundColor: .white, tintColor: .black, title: "Login", preferredLargeTitle: false)

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

    private func confugreLayout() {
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(activityIndicator)

        bottomLoginConstraint = loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                                    constant: -20.0)
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.0),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.0),

            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30.0),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.0),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.0),

            loginButton.heightAnchor.constraint(equalToConstant: 47.0),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.0),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.0),
            bottomLoginConstraint,

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc
    private func popToPrevious() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    private func onLoginPressed() {
        activityIndicator.startAnimating()
        presenter.onLoginPressed(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }

    @objc
    private func onTextFieldChanged() {
        let isUsernameTextFieldEmpty = usernameTextField.text?.isEmpty ?? true
        let isPasswordTextFieldEmpty = passwordTextField.text?.isEmpty ?? true
        loginButton.isEnabled = !isUsernameTextFieldEmpty && !isPasswordTextFieldEmpty
    }

    @objc
    private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let keyboardHeight = keyboardSize.height
        self.bottomLoginConstraint.constant = view.safeAreaInsets.bottom - keyboardHeight - 20
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

    @objc
    private func keyboardWillHide(notification: Notification) {
        self.bottomLoginConstraint.constant = -20
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}

extension LoginViewController {

    func onLoginError(error: String) {
        activityIndicator.stopAnimating()

        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
