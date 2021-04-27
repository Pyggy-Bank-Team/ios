import Swinject
import SwinjectAutoregistration
import UIKit

final class CategorySceneAssembly: Assembly {
    
    let categoryDomainModel: DomainCategoryModel?
    
    init(categoryDomainModel: DomainCategoryModel?) {
        self.categoryDomainModel = categoryDomainModel
    }

    func assemble(container: Container) {
        container.autoregister(CategoriesDataSource.self, initializer: CategoriesRemoteDataSource.init)
        container.autoregister(CategoriesRepository.self, initializer: CategoriesDataRepository.init)
        container.autoregister(CreateUpdateCategoryUseCase.self, initializer: CreateUpdateCategoryUseCase.init)
        container.autoregister(DeleteCategoryUseCase.self, initializer: DeleteCategoryUseCase.init)

        container.register(CategoryPresenter.self) { resolver in
            CategoryPresenter(
                categoryDomainModel: self.categoryDomainModel,
                view: resolver.resolve(CategoryViewController.self),
                createUpdateCategoryUseCase: resolver.resolve(CreateUpdateCategoryUseCase.self),
                deleteCategoryUseCase: resolver.resolve(DeleteCategoryUseCase.self)
            )
        }
        container.register(CategoryViewController.self) { _ in CategoryViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(CategoryPresenter.self)
            }
    }
    
}
