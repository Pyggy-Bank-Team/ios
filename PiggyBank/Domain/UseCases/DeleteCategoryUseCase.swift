import Foundation

final class DeleteCategoryUseCase: UseCase<UseCasesDTOs.DeleteCategory.Request, UseCasesDTOs.DeleteCategory.Response> {
    
    private let apiManager = APIManager.shared
    
    override func execute(request: UseCasesDTOs.DeleteCategory.Request, completion: @escaping (UseCasesDTOs.DeleteCategory.Response) -> Void) {
        apiManager.deleteCategory(request: .init(id: request.id)) { response in
            completion(.init(result: response.result))
        }
    }

}
