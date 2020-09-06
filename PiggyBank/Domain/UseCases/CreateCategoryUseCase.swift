import Foundation

final class CreateCategoryUseCase: UseCase<UseCasesDTOs.CreateCategory.Request, UseCasesDTOs.CreateCategory.Response> {
    
    private let apiManager = APIManager.shared
    
    override func execute(request: UseCasesDTOs.CreateCategory.Request, completion: @escaping (UseCasesDTOs.CreateCategory.Response) -> Void) {
        apiManager.createCategory(request: .init(title: request.title, hexColor: request.hexColor, type: request.type)) { response in
            completion(.init(result: response.result))
        }
    }

}
