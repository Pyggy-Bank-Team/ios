import Foundation

final class DeleteAccountUseCase {
    
    private let apiManager = APIManager.shared
    
    func execute(accountID: Int, completion: @escaping (Result<Void>) -> Void) {
        apiManager.deleteAccount(accountID: accountID, completion: completion)
    }

}
