import Foundation

final class AuthPresenter {
    
    private let mode: AuthSceneMode
    
    private weak var view: AuthViewController?
    
    private let signInUseCase = SignInUseCase()
    private let signUpUseCase = SignUpUseCase()
    
    init(mode: AuthSceneMode, view: AuthViewController?) {
        self.mode = mode
        self.view = view
    }
    
    func viewDidLoad() {
        view?.viewDidLoad(mode: mode)
    }
    
    func onPrimaryAction(username: String, password: String) {
        if mode == .signIn {
            signInUseCase.execute(request: .init(username: username, password: password)) { [weak self] response in
                DispatchQueue.main.async {
                    if case let .success(token) = response.result {
                        let profileVC = ProfileViewController()
                        self?.view?.onPrimaryAction(viewController: profileVC)
                    }
                }
            }
        } else {
            //signUpUseCase.execute(request: .init(username: username, password: password)) { [weak self] response in
                DispatchQueue.main.async {
                    //if case .success = response.result {
                    let baseCurrencyVC = BaseCurrencySceneAssembly(initialNickname: username, initialPassword: password).build()
                        self.view?.onPrimaryAction(viewController: baseCurrencyVC)
                    //}
                }
            //}
        }
    }
    
    func onSecondaryAction() {
        if mode == .signIn {
            let signUpVC = AuthSceneAssembly(mode: .signUp).build()
            view?.onSecondaryAction(viewController: signUpVC)
        }
    }
    
}
