import Foundation

final class ChangeCategoryUseCase: UseCase<UseCasesDTOs.ChangeCategory.Request, UseCasesDTOs.ChangeCategory.Response> {
    
    private let apiManager = APIManager.shared
    
    override func execute(request: UseCasesDTOs.ChangeCategory.Request, completion: @escaping (UseCasesDTOs.ChangeCategory.Response) -> Void) {
        let apiCategory = APIDTOs.ChangeCategory.Request(
            categoryID: request.categoryID,
            categoryTitle: request.categoryTitle,
            categoryColor: request.categoryColor
        )
        
        apiManager.changeCategory(request: apiCategory) { response in
            completion(.init(result: response.result))
        }
    }

}
