import Foundation

final class GetAccountsUseCase {

    private let getAccountsRepository: AccountRepository?

    init(getAccountsRepository: AccountRepository?) {
        self.getAccountsRepository = getAccountsRepository
    }

    func execute(completion: @escaping (Result<[DomainAccountModel]>) -> Void) {
        getAccountsRepository?.getAccounts(completion: completion)
    }

}
