import Foundation

protocol CreateUpdateCategoryRepository {
    func updateCategory(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void)
    func createCategory(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void)
}

final class CreateUpdateCategoryUseCase {
    
    private let createUpdateCategoryRepository: CreateUpdateCategoryRepository

    init(createUpdateCategoryRepository: CreateUpdateCategoryRepository) {
        self.createUpdateCategoryRepository = createUpdateCategoryRepository
    }

    func execute(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void) {
        if request.id != nil {
            createUpdateCategoryRepository.updateCategory(request: request, completion: completion)
        } else {
            createUpdateCategoryRepository.createCategory(request: request, completion: completion)
        }
    }

}
