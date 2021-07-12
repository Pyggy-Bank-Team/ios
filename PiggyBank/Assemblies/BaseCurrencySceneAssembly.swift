import Swinject
import SwinjectAutoregistration
import UIKit

final class BaseCurrencySceneAssembly: Assembly {
    
    func assemble(container: Container) {
        container.autoregister(CurrenciesDataSource.self, initializer: CurrenciesRemoteDataSource.init)
        container.autoregister(CurrenciesRepository.self, initializer: CurrenciesDataRepository.init)
        container.autoregister(GetCurrenciesUseCase.self, initializer: GetCurrenciesUseCase.init)

        container.register(BaseCurrencyPresenter.self) { resolver in
            guard let GetCurrenciesUseCase = resolver.resolve(GetCurrenciesUseCase.self) else {
                fatalError("GetCurrenciesUseCase cannot be resolved")
            }
            return BaseCurrencyPresenter(
                view: resolver.resolve(BaseCurrencyViewController.self),
                getCurrenciesUseCase: GetCurrenciesUseCase
            )
        }
        container.register(BaseCurrencyViewController.self) { _ in BaseCurrencyViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(BaseCurrencyPresenter.self)
            }
    }

}
