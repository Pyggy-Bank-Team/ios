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
            .inObjectScope(.signIn)
        container.autoregister(SaveUserCredentialsRepository.self, initializer: SaveUserCredentialsDataRepository.init)
            .inObjectScope(.signIn)
        container.autoregister(SignInRepository.self, initializer: SignInDataRepository.init)
            .inObjectScope(.signIn)
        container.autoregister(SignInUseCase.self, initializer: SignInUseCase.init)
            .inObjectScope(.signIn)

        container.autoregister(SignUpDataSource.self, initializer: SignUpRemoteDataSource.init)
            .inObjectScope(.signUp)
        container.autoregister(SaveUserCredentialsRepository.self, initializer: SaveUserCredentialsDataRepository.init)
            .inObjectScope(.signUp)
        container.autoregister(SignUpRepository.self, initializer: SignUpDataRepository.init)
            .inObjectScope(.signUp)
        container.autoregister(SignUpUseCase.self, initializer: SignUpUseCase.init)
            .inObjectScope(.signUp)

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

extension ObjectScope {
    static let signIn = ObjectScope(
        storageFactory: PermanentStorage.init,
        description: "signIn"
    )
    static let signUp = ObjectScope(
        storageFactory: PermanentStorage.init,
        description: "signIn"
    )
}
