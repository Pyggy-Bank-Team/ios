import Swinject
import SwinjectAutoregistration
import UIKit

final class BaseCurrencySceneAssembly: Assembly {
    
    private let initialNickname: String
    private let initialPassword: String
    
    init(initialNickname: String, initialPassword: String) {
        self.initialNickname = initialNickname
        self.initialPassword = initialPassword
    }
    
    func assemble(container: Container) {
        container.autoregister(CurrenciesDataSource.self, initializer: CurrenciesRemoteDataSource.init)
        container.autoregister(CurrenciesRepository.self, initializer: CurrenciesDataRepository.init)
        container.autoregister(SignUpDataSource.self, initializer: SignUpRemoteDataSource.init)
        container.autoregister(UserCredentialsRepository.self, initializer: UserCredentialsDataRepository.init)
        container.autoregister(SignUpRepository.self, initializer: SignUpDataRepository.init)

        container.autoregister(GetCurrenciesUseCase.self, initializer: GetCurrenciesUseCase.init)
        container.autoregister(SaveUserCredentialsUseCase.self, initializer: SaveUserCredentialsUseCase.init)
        container.autoregister(SignUpUseCase.self, initializer: SignUpUseCase.init)

        container.register(BaseCurrencyPresenter.self) { resolver in
            BaseCurrencyPresenter(
                initialNickname: self.initialNickname,
                initialPassword: self.initialPassword,
                view: resolver.resolve(BaseCurrencyViewController.self),
                getCurrenciesUseCase: resolver.resolve(GetCurrenciesUseCase.self),
                signUpUseCase: resolver.resolve(SignUpUseCase.self)
            )
        }
        container.register(BaseCurrencyViewController.self) { _ in BaseCurrencyViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(BaseCurrencyPresenter.self)
            }
    }

}
