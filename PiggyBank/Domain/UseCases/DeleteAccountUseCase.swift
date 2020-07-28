import Foundation

final class DeleteAccountUseCase: UseCase<UseCasesDTOs.DeleteAccount.Request, UseCasesDTOs.DeleteAccount.Response> {
    
    private let apiManager = APIManager.shared
    
    override func execute(request: UseCasesDTOs.DeleteAccount.Request, completion: @escaping (UseCasesDTOs.DeleteAccount.Response) -> Void) {
        apiManager.deleteAccount(request: .init(id: request.id)) { response in
            completion(.init(result: response.result))
        }
    }

}
