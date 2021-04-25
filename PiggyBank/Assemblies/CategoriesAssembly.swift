import Swinject
import SwinjectAutoregistration
import UIKit

final class CategoriesAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(GetCategoriesDataSource.self, initializer: GetCategoriesRemoteDataSource.init)
        container.autoregister(GetCategoriesRepository.self, initializer: GetCategoriesDataRepository.init)
        container.autoregister(GetCategoriesUseCase.self, initializer: GetCategoriesUseCase.init)
        container.autoregister(CategoriesPresenter.self, initializer: CategoriesPresenter.init)
        container.register(CategoriesViewController.self) { _ in CategoriesViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(CategoriesPresenter.self)
            }
    }
    
}
