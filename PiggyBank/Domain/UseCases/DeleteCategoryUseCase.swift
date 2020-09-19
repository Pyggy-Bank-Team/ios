import Foundation

final class DeleteCategoryUseCase {
    
    private let apiManager = APIManager.shared
    
    func execute(categoryID: Int, completion: @escaping (Result<Void>) -> Void) {
        apiManager.deleteCategory(categoryID: categoryID, completion: completion)
    }

}
