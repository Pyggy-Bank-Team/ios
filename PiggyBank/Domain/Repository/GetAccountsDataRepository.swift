//
//  GetAccountsDataRepository.swift
//  PiggyBank
//

protocol GetAccountsDataSource {
    func getAccounts(completion: @escaping (Result<[DomainAccountModel]>) -> Void)
}

class GetAccountsDataRepository: GetAccountsRepository {

    private let remoteDataSource: GetAccountsDataSource?

    init(remoteDataSource: GetAccountsDataSource?) {
        self.remoteDataSource = remoteDataSource
    }

    func getAccounts(completion: @escaping (Result<[DomainAccountModel]>) -> Void) {
        remoteDataSource?.getAccounts(completion: completion)
    }
}
