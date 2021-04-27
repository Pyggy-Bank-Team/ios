//
//  CreateUpdateAccountDataRepository.swift
//  PiggyBank
//

protocol AccountDataSource {
    func createAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void)
    func updateAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void)
    func deleteAccount(accountID: Int, completion: @escaping (Result<Void>) -> Void)
    func getAccounts(completion: @escaping (Result<[DomainAccountModel]>) -> Void)
}

class AccountDataRepository: AccountRepository {

    private let remoteDataSource: AccountDataSource?

    init(remoteDataSource: AccountDataSource?) {
        self.remoteDataSource = remoteDataSource
    }

    func createAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void) {
        remoteDataSource?.createAccount(request: request, completion: completion)
    }

    func updateAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void) {
        remoteDataSource?.updateAccount(request: request, completion: completion)
    }

    func deleteAccount(accountID: Int, completion: @escaping (Result<Void>) -> Void) {
        remoteDataSource?.deleteAccount(accountID: accountID, completion: completion)
    }

    func getAccounts(completion: @escaping (Result<[DomainAccountModel]>) -> Void) {
        remoteDataSource?.getAccounts(completion: completion)
    }
}
