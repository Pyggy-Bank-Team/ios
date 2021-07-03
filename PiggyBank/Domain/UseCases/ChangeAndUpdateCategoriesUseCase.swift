import Foundation

final class ChangeAndUpdateCategoriesUseCase {
    
    private let createUpdateCategoryUseCase: CreateUpdateCategoryUseCase
    private let getCategoriesUseCase: GetCategoriesUseCase
    
    private let semaphore = DispatchSemaphore(value: 0)

    init(createUpdateCategoryUseCase: CreateUpdateCategoryUseCase, getCategoriesUseCase: GetCategoriesUseCase) {
        self.createUpdateCategoryUseCase = createUpdateCategoryUseCase
        self.getCategoriesUseCase = getCategoriesUseCase
    }
    
    func execute(category: DomainCategoryModel, completion: @escaping (Result<[DomainCategoryModel]>) -> Void) {
        DispatchQueue.global().async {
            self.createUpdateCategoryUseCase.execute(request: category) { [weak self] _ in
                self?.semaphore.signal()
            }
            
            self.semaphore.wait()
            self.getCategoriesUseCase.execute(completion: completion)
        }
    }
    
}
