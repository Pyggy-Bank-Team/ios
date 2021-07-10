import Foundation

final class ChangeAndUpdateCategoriesUseCase {
    
    private let createUpdateCategoryUseCase: CreateUpdateCategoryUseCase
    private let getCategoriesUseCase: GetCategoriesUseCase

    init(createUpdateCategoryUseCase: CreateUpdateCategoryUseCase, getCategoriesUseCase: GetCategoriesUseCase) {
        self.createUpdateCategoryUseCase = createUpdateCategoryUseCase
        self.getCategoriesUseCase = getCategoriesUseCase
    }
    
    func execute(category: DomainCategoryModel, completion: @escaping (Result<[DomainCategoryModel]>) -> Void) {
        DispatchQueue.global().async { [weak self] in
            self?.createUpdateCategoryUseCase.execute(request: category) { [weak self] _ in
                self?.getCategoriesUseCase.execute(completion: completion)
            }
        }
    }
    
}
