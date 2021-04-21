import Foundation

protocol DeleteAccountRepository {
    func deleteAccount(accountID: Int, completion: @escaping (Result<Void>) -> Void)
}

final class DeleteAccountUseCase {

    private let deleteAccountRepository: DeleteAccountRepository

    init(deleteAccountRepository: DeleteAccountRepository) {
        self.deleteAccountRepository = deleteAccountRepository
    }

    func execute(accountID: Int, completion: @escaping (Result<Void>) -> Void) {
        deleteAccountRepository.deleteAccount(accountID: accountID, completion: completion)
    }

}
