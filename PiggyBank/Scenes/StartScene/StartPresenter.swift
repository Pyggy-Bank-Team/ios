import UIKit

final class StartPresenter {
    
    private weak var view: StartViewController?
    private let getUserCredentials: GetUserCredentialsUseCase?

    init(view: StartViewController?, getUserCredentials: GetUserCredentialsUseCase?) {
        self.view = view
        self.getUserCredentials = getUserCredentials
    }

    func viewDidLoad() {
        getUserCredentials?.execute { [weak self] result in
            if case let .success(model) = result {
                let assembler = DependencyProvider.shared.assembler
                assembler.apply(assembly: AuthSceneAssembly(mode: .signIn))
                var vcs: [UIViewController] = [assembler.resolver.resolve(AuthViewController.self)!]

                if model != nil {
                    let profileVC = DependencyProvider.shared.assembler.resolver.resolve(ProfileViewController.self)!
                    vcs.append(profileVC)
                }

                DispatchQueue.main.async {
                    self?.view?.viewDidLoad(vcs: vcs)
                }
            }
        }

//        view?.viewDidLoad(vcs: [AuthSceneAssembly(mode: .signIn).build()])
    }
    
}
