import Foundation

final class GetCategoriesUseCase {
    
    private let apiManager = APIManager.shared
    
    func execute(completion: @escaping (Result<[DomainCategoryModel]>) -> Void) {
        apiManager.getCategories(completion: completion)
    }

}
