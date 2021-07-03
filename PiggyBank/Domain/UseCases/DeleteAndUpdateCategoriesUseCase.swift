import Foundation

final class DeleteAndUpdateCategoriesUseCase {
    
    private let deleteCategoryUseCase: DeleteCategoryUseCase
    private let getCategoriesUseCase: GetCategoriesUseCase
    
    private let semaphore = DispatchSemaphore(value: 0)

    init(deleteCategoryUseCase: DeleteCategoryUseCase, getCategoriesUseCase: GetCategoriesUseCase) {
        self.deleteCategoryUseCase = deleteCategoryUseCase
        self.getCategoriesUseCase = getCategoriesUseCase
    }
    
    func execute(category: DomainCategoryModel, completion: @escaping (Result<[DomainCategoryModel]>) -> Void) {
        DispatchQueue.global().async {
            self.deleteCategoryUseCase.execute(categoryID: category.id!) { [weak self] _ in
                self?.semaphore.signal()
            }
            
            self.semaphore.wait()
            self.getCategoriesUseCase.execute(completion: completion)
        }
    }
    
}
