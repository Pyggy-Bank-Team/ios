import Foundation

final class DeleteAndUpdateAccountsUseCase {
    
    private let deleteAccountUseCase: DeleteAccountUseCase
    private let getAccountsUseCase: GetAccountsUseCase
    
    private let semaphore = DispatchSemaphore(value: 0)

    init(deleteAccountUseCase: DeleteAccountUseCase, getAccountsUseCase: GetAccountsUseCase) {
        self.deleteAccountUseCase = deleteAccountUseCase
        self.getAccountsUseCase = getAccountsUseCase
    }
    
    func execute(account: DomainAccountModel, completion: @escaping (Result<[DomainAccountModel]>) -> Void) {
        DispatchQueue.global().async {
            self.deleteAccountUseCase.execute(accountID: account.id!) { [weak self] _ in
                self?.semaphore.signal()
            }
            
            self.semaphore.wait()
            self.getAccountsUseCase.execute(completion: completion)
        }
    }
    
}
