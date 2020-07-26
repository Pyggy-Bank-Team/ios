import Foundation

final class GetAccountsUseCase: UseCase<UseCasesDTOs.GetAccounts.Request, UseCasesDTOs.GetAccounts.Response> {
    
    private let apiManager = APIManager.shared
    
    override func execute(request: UseCasesDTOs.GetAccounts.Request, completion: @escaping (UseCasesDTOs.GetAccounts.Response) -> Void) {
        apiManager.getAccounts(request: .init()) { response in
            if case let .success(items) = response.result {
                let result = items
                    .filter { !$0.isArchived }
                    .map { UseCasesDTOs.GetAccounts.Response.Account(title: $0.title, currency: $0.currency, balance: $0.balance, isArchived: $0.isArchived) }
                
                completion(.init(result: .success(result)))
            }
            
            if case let .error(error) = response.result {
                completion(.init(result: .error(error)))
            }
        }
    }

}
