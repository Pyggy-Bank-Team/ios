import Foundation

final class CreateUpdateCategoryUseCase {
    
    private let createUpdateCategoryRepository: CategoriesRepository?

    init(createUpdateCategoryRepository: CategoriesRepository?) {
        self.createUpdateCategoryRepository = createUpdateCategoryRepository
    }

    func execute(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void) {
        if request.id != nil {
            createUpdateCategoryRepository?.updateCategory(request: request, completion: completion)
        } else {
            createUpdateCategoryRepository?.createCategory(request: request, completion: completion)
        }
    }

}
