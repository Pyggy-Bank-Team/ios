//
//  CreateUpdateAccountDataRepository.swift
//  PiggyBank
//

protocol CreateUpdateAccountDataSource {
    func createAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void)
    func updateAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void)
}

class CreateUpdateAccountDataRepository: CreateUpdateAccountRepository {

    private let remoteDataSource: CreateUpdateAccountDataSource?

    init(remoteDataSource: CreateUpdateAccountDataSource?) {
        self.remoteDataSource = remoteDataSource
    }

    func createAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void) {
        remoteDataSource?.createAccount(request: request, completion: completion)
    }

    func updateAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void) {
        remoteDataSource?.updateAccount(request: request, completion: completion)
    }

}
