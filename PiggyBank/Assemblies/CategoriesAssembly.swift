import Swinject
import SwinjectAutoregistration
import UIKit

final class CategoriesAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(CategoriesDataSource.self, initializer: CategoriesRemoteDataSource.init)
        container.autoregister(CategoriesRepository.self, initializer: CategoriesDataRepository.init)
        container.autoregister(GetCategoriesUseCase.self, initializer: GetCategoriesUseCase.init)
        container.autoregister(DeleteCategoryUseCase.self, initializer: DeleteCategoryUseCase.init)
        container.autoregister(DeleteAndUpdateCategoriesUseCase.self, initializer: DeleteAndUpdateCategoriesUseCase.init)
        container.autoregister(CreateUpdateCategoryUseCase.self, initializer: CreateUpdateCategoryUseCase.init)
        container.autoregister(ChangeAndUpdateCategoriesUseCase.self, initializer: ChangeAndUpdateCategoriesUseCase.init)
        container.autoregister(CategoriesPresenter.self, initializer: CategoriesPresenter.init)
        
        container.register(CategoriesViewController.self) { _ in CategoriesViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(CategoriesPresenter.self)
            }
    }
    
}
