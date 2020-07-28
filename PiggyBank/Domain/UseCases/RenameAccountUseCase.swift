import Foundation

final class RenameAccountUseCase: UseCase<UseCasesDTOs.RenameAccount.Request, UseCasesDTOs.RenameAccount.Response> {
    
    private let apiManager = APIManager.shared
    
    override func execute(request: UseCasesDTOs.RenameAccount.Request, completion: @escaping (UseCasesDTOs.RenameAccount.Response) -> Void) {
        let domainAccount = request.account
        
        let apiAccount = APIDTOs.RenameAccount.Request.Account(
            id: domainAccount.id,
            type: domainAccount.type,
            title: request.title,
            currency: domainAccount.currency,
            balance: domainAccount.balance
        )
        
        apiManager.renameAccount(request: .init(account: apiAccount)) { response in
            completion(.init(result: response.result))
        }
    }

}
