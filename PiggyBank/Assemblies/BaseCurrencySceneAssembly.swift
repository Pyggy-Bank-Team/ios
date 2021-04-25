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
        container.autoregister(GetCurrenciesDataSource.self, initializer: GetCurrenciesRemoteDataSource.init)
        container.autoregister(GetCurrenciesRepository.self, initializer: GetCurrenciesDataRepository.init)
        container.autoregister(GetCurrenciesUseCase.self, initializer: GetCurrenciesUseCase.init)

        container.autoregister(SignUpDataSource.self, initializer: SignUpRemoteDataSource.init)
        container.autoregister(SaveUserCredentialsRepository.self, initializer: SaveUserCredentialsDataRepository.init)
        container.autoregister(SignUpRepository.self, initializer: SignUpDataRepository.init)
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
