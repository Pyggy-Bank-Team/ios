import UIKit

final class AuthViewController: UIViewController {
    
    private lazy var nicknameField = UITextField()
    private lazy var passwordField = UITextField()
    private lazy var actionButton = UIButton(type: .system)
    private lazy var hintButton = UIButton(type: .system)
    
    var presenter: IAuthPresenter!
    
    private let api = APIManager()
    
    var onButtonAction: ((UIButton) -> Void)?
    var onHintButtonAction: ((UIButton) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter.onViewDidLoad(request: .init())
    }

}

extension AuthViewController: IAuthView {
    
    func onViewDidLoad(response: AuthDTOs.ViewDidLoad.Response) {
        navigationItem.title = response.screenTitle
        actionButton.setTitle(response.screenTitle, for: .normal)
        hintButton.setTitle(response.hintActionTitle, for: .normal)
    }
    
    func onPrimaryAction(response: AuthDTOs.PrimaryAction.Response) {
        let alertController = UIAlertController(title: response.message, message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
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
        
        nicknameField.placeholder = "nickname..."
        
        passwordField.placeholder = "password..."
        passwordField.isSecureTextEntry = true
        
        actionButton.addTarget(self, action: #selector(onPrimaryAction(_:)), for: .touchUpInside)
        hintButton.addTarget(self, action: #selector(onHintAction(_:)), for: .touchUpInside)
        
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
    
    @objc func onHintAction(_ sender: UIButton) {
        onHintButtonAction?(sender)
    }
    
    @objc func onPrimaryAction(_ sender: UIButton) {
        presenter.onPrimaryAction(request: .init(username: nicknameField.text ?? "", password: passwordField.text ?? ""))
    }
    
}
