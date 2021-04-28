import Swinject
import SwinjectAutoregistration
import UIKit

enum AuthSceneMode {
    case signIn
    case signUp
}

final class AuthSceneAssembly: Assembly {
    
    let mode: AuthSceneMode
    
    init(mode: AuthSceneMode) {
        self.mode = mode
    }

    func assemble(container: Container) {
        container.autoregister(SignInDataSource.self, initializer: SignInRemoteDataSource.init)
        container.autoregister(UserCredentialsRepository.self, initializer: UserCredentialsDataRepository.init)
        container.autoregister(SignInRepository.self, initializer: SignInDataRepository.init)
        container.autoregister(SignUpDataSource.self, initializer: SignUpRemoteDataSource.init)
        container.autoregister(SignUpRepository.self, initializer: SignUpDataRepository.init)

        container.autoregister(SaveUserCredentialsUseCase.self, initializer: SaveUserCredentialsUseCase.init)
        container.autoregister(SignInUseCase.self, initializer: SignInUseCase.init)
        container.autoregister(SignUpUseCase.self, initializer: SignUpUseCase.init)

        container.register(AuthPresenter.self) { resolver in
            AuthPresenter(
                mode: self.mode,
                view: resolver.resolve(AuthViewController.self),
                signInUseCase: resolver.resolve(SignInUseCase.self),
                signUpUseCase: resolver.resolve(SignUpUseCase.self)
            )
        }
        container.register(AuthViewController.self) { _ in AuthViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(AuthPresenter.self)
            }
    }

}
