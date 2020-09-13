import UIKit

final class AuthViewController: UIViewController {
    
    private lazy var nicknameField = UITextField()
    private lazy var passwordField = UITextField()
    private lazy var actionButton = UIButton(type: .system)
    private lazy var hintButton = UIButton(type: .system)
    
    private var mode: AuthSceneMode!
    
    var presenter: AuthPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter.viewDidLoad()
    }
    
    func viewDidLoad(mode: AuthSceneMode) {
        self.mode = mode
        
        let navigationTitle: String
        let primaryActionTitle: String
        let secondaryActionTitle: String
        
        if mode == .signIn {
            navigationTitle = "Sign in"
            primaryActionTitle = "Sign in"
            secondaryActionTitle = "Don't have an account? Sign up"
        } else {
            navigationTitle = "Sign up"
            primaryActionTitle = "Next"
            secondaryActionTitle = "Already have an account? Sign in"
        }
        
        navigationItem.title = navigationTitle
        actionButton.setTitle(primaryActionTitle, for: .normal)
        hintButton.setTitle(secondaryActionTitle, for: .normal)
    }
    
    func onPrimaryAction(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func onSecondaryAction(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

}

private extension AuthViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        
        [nicknameField, passwordField, actionButton, hintButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [nicknameField, passwordField].forEach { textField in
            textField.borderStyle = .roundedRect
            textField.textAlignment = .center
        }
        
        [actionButton, hintButton].forEach {
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0.01, bottom: 0.01, right: 0)
        }
        
        nicknameField.text = "vasyapupkin"
        passwordField.text = "qwerty123"
        
        nicknameField.placeholder = "nickname..."
        
        passwordField.placeholder = "password..."
        passwordField.isSecureTextEntry = true
        
        actionButton.addTarget(self, action: #selector(onPrimaryAction(_:)), for: .touchUpInside)
        hintButton.addTarget(self, action: #selector(onSecondaryAction(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            nicknameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nicknameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 180),
            nicknameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            passwordField.centerXAnchor.constraint(equalTo: nicknameField.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: nicknameField.bottomAnchor, constant: 20),
            passwordField.widthAnchor.constraint(equalTo: nicknameField.widthAnchor),
            
            actionButton.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor),
            actionButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40),
            
            hintButton.centerXAnchor.constraint(equalTo: actionButton.centerXAnchor),
            hintButton.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 15),
        ])
    }
    
    @objc func onPrimaryAction(_ sender: UIButton) {
        presenter.onPrimaryAction(username: nicknameField.text ?? "", password: passwordField.text ?? "")
    }
    
    @objc func onSecondaryAction(_ sender: UIButton) {
        if mode == .signIn {
            presenter.onSecondaryAction()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
}
