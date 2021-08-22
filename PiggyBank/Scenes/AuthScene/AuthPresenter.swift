import Foundation

final class AuthPresenter {
    
    private let mode: AuthSceneMode
    private weak var view: AuthViewController?
    private let signInUseCase: SignInUseCase?
    private let signUpUseCase: SignUpUseCase?

    init(mode: AuthSceneMode, view: AuthViewController?, signInUseCase: SignInUseCase?, signUpUseCase: SignUpUseCase?) {
        self.mode = mode
        self.view = view
        self.signInUseCase = signInUseCase
        self.signUpUseCase = signUpUseCase
    }

    func viewDidLoad() {
        view?.viewDidLoad(mode: mode)
    }
    
    func onPrimaryAction(username: String, password: String) {
        if mode == .signIn {
            let domainSignInModel = DomainSignInModel(nickname: username, password: password)
            signInUseCase?.execute(domainSignInModel: domainSignInModel) { [weak self] result in
                DispatchQueue.main.async {
                    if case .success = result {
                        self?.view?.onPrimaryAction(viewController: DependencyProvider.shared.get(screen: .profile))
                    }
                }
            }
        } else {
            view?.onPrimaryAction(viewController: DependencyProvider.shared.get(screen: .currency))
        }
    }

    func onSecondaryAction() {
        if mode == .signIn {
            view?.onSecondaryAction(viewController: DependencyProvider.shared.get(screen: .auth(.signUp)))
        }
    }
}
