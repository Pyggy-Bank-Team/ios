import Foundation

final class ArchiveCategoryUseCase: UseCase<UseCasesDTOs.ArchiveCategory.Request, UseCasesDTOs.ArchiveCategory.Response> {
    
    private let apiManager = APIManager.shared
    
    override func execute(request: UseCasesDTOs.ArchiveCategory.Request, completion: @escaping (UseCasesDTOs.ArchiveCategory.Response) -> Void) {
        apiManager.archiveCategory(request: .init(id: request.id)) { response in
            completion(.init(result: response.result))
        }
    }

}

