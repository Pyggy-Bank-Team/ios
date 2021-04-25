import Foundation

protocol GetAccountsRepository {
    func getAccounts(completion: @escaping (Result<[DomainAccountModel]>) -> Void)
}

final class GetAccountsUseCase {

    private let getAccountsRepository: GetAccountsRepository?

    init(getAccountsRepository: GetAccountsRepository?) {
        self.getAccountsRepository = getAccountsRepository
    }

    func execute(completion: @escaping (Result<[DomainAccountModel]>) -> Void) {
        getAccountsRepository?.getAccounts(completion: completion)
    }

}
