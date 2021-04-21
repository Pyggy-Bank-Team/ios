import Foundation

final class AuthPresenter {
    
    private let mode: AuthSceneMode
    
    private weak var view: AuthViewController?
    
    private let signInUseCase = SignInUseCase(signInRepository: SignInDataRepository(remoteDataSource: APIManager.shared), saveUserCredentialsRepository: SaveUserCredentialsDataRepository())
    private let signUpUseCase = SignUpUseCase(signUpRepository: SignUpDataRepository(remoteDataSource: SignUpRemoteDataSource()), saveUserCredentialsRepository: SaveUserCredentialsDataRepository())

    init(mode: AuthSceneMode, view: AuthViewController?) {
        self.mode = mode
        self.view = view
    }
    
    func viewDidLoad() {
        view?.viewDidLoad(mode: mode)
    }
    
    func onPrimaryAction(username: String, password: String) {
        if mode == .signIn {
            let domainSignInModel = DomainSignInModel(nickname: username, password: password)
            
            signInUseCase.execute(domainSignInModel: domainSignInModel) { [weak self] result in
                DispatchQueue.main.async {
                    if case .success = result {
                        let profileVC = ProfileSceneAssembly().build()
                        self?.view?.onPrimaryAction(viewController: profileVC)
                    }
                }
            }
        } else {
            let baseCurrencyVC = BaseCurrencySceneAssembly(initialNickname: username, initialPassword: password).build()
            view?.onPrimaryAction(viewController: baseCurrencyVC)
        }
    }
    
    func onSecondaryAction() {
        if mode == .signIn {
            let signUpVC = AuthSceneAssembly(mode: .signUp).build()
            view?.onSecondaryAction(viewController: signUpVC)
        }
    }
    
}
