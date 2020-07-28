import Foundation

final class ArchiveAccountUseCase: UseCase<UseCasesDTOs.ArchiveAccount.Request, UseCasesDTOs.ArchiveAccount.Response> {
    
    private let apiManager = APIManager.shared
    
    override func execute(request: UseCasesDTOs.ArchiveAccount.Request, completion: @escaping (UseCasesDTOs.ArchiveAccount.Response) -> Void) {
        apiManager.archiveAccount(request: .init(id: request.id)) { response in
            completion(.init(result: response.result))
        }
    }

}
