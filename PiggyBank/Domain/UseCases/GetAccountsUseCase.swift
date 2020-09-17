import Foundation

final class GetAccountsUseCase {
    
    private let apiManager = APIManager.shared
    
    func execute(completion: @escaping (Result<[DomainAccountModel]>) -> Void) {
        apiManager.getAccounts(completion: completion)
    }

}
