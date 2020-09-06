import Foundation

final class GetCategoriesUseCase: UseCase<UseCasesDTOs.GetCategories.Request, UseCasesDTOs.GetCategories.Response> {
    
    private let apiManager = APIManager.shared
    
    override func execute(request: UseCasesDTOs.GetCategories.Request, completion: @escaping (UseCasesDTOs.GetCategories.Response) -> Void) {
        apiManager.getCategories(request: .init()) { response in
            if case let .success(items) = response.result {
                let result = items
                    .map {
                        DomainCategoryModel(
                            id: $0.id, title: $0.title, hexColor: $0.hexColor, type: $0.type, isArchived: $0.isArchived
                        )
                    }
                
                completion(.init(result: .success(result)))
            }
            
            if case let .error(error) = response.result {
                completion(.init(result: .error(error)))
            }
        }
    }

}
