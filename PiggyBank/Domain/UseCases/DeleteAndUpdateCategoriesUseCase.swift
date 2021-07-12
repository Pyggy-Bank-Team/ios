import Foundation

final class DeleteAndUpdateCategoriesUseCase {
    
    private let deleteCategoryUseCase: DeleteCategoryUseCase
    private let getCategoriesUseCase: GetCategoriesUseCase

    init(deleteCategoryUseCase: DeleteCategoryUseCase, getCategoriesUseCase: GetCategoriesUseCase) {
        self.deleteCategoryUseCase = deleteCategoryUseCase
        self.getCategoriesUseCase = getCategoriesUseCase
    }
    
    func execute(category: DomainCategoryModel, completion: @escaping (Result<[DomainCategoryModel]>) -> Void) {
        DispatchQueue.global().async { [weak self] in
            self?.deleteCategoryUseCase.execute(categoryID: category.id!) { [weak self] _ in
                self?.getCategoriesUseCase.execute(completion: completion)
            }
        }
    }
    
}
