import Foundation

final class DeleteAccountUseCase {

    private let deleteAccountRepository: AccountRepository?

    init(deleteAccountRepository: AccountRepository?) {
        self.deleteAccountRepository = deleteAccountRepository
    }

    func execute(accountID: Int, completion: @escaping (Result<Void>) -> Void) {
        deleteAccountRepository?.deleteAccount(accountID: accountID, completion: completion)
    }

}
