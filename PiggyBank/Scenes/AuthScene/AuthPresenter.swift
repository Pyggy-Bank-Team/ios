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
                        let profileVC = DependencyProvider.shared.assembler.resolver.resolve(ProfileViewController.self)!
                        self?.view?.onPrimaryAction(viewController: profileVC)
                    }
                }
            }
        } else {
            let assembler = DependencyProvider.shared.assembler
            assembler.apply(assembly: BaseCurrencySceneAssembly(initialNickname: username, initialPassword: password))
            view?.onPrimaryAction(viewController: assembler.resolver.resolve(BaseCurrencyViewController.self)!)
        }
    }

    func onSecondaryAction() {
        if mode == .signIn {
            let assembler = DependencyProvider.shared.assembler
            assembler.apply(assembly: AuthSceneAssembly(mode: .signUp))
            view?.onSecondaryAction(viewController: assembler.resolver.resolve(AuthViewController.self)!)
        }
    }
}
