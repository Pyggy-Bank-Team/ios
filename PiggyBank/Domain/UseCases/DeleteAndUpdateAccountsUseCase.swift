import Foundation

final class DeleteAndUpdateAccountsUseCase {
    
    private let deleteAccountUseCase: DeleteAccountUseCase
    private let getAccountsUseCase: GetAccountsUseCase

    init(deleteAccountUseCase: DeleteAccountUseCase, getAccountsUseCase: GetAccountsUseCase) {
        self.deleteAccountUseCase = deleteAccountUseCase
        self.getAccountsUseCase = getAccountsUseCase
    }
    
    func execute(account: DomainAccountModel, completion: @escaping (Result<[DomainAccountModel]>) -> Void) {
        DispatchQueue.global().async { [weak self] in
            self?.deleteAccountUseCase.execute(accountID: account.id!) { [weak self] _ in
                self?.getAccountsUseCase.execute(completion: completion)
            }
        }
    }
    
}
