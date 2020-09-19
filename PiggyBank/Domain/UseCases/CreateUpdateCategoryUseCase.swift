import Foundation

final class CreateUpdateCategoryUseCase {
    
    private let apiManager = APIManager.shared
    
    func execute(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void) {
        if request.id != nil {
            apiManager.updateCategory(request: request, completion: completion)
        } else {
            apiManager.createCategory(request: request, completion: completion)
        }
    }

}
