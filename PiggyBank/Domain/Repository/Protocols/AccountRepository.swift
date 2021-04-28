//
//  AccountRepository.swift
//  PiggyBank
//

protocol AccountRepository {
    func createAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void)
    func updateAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void)
    func deleteAccount(accountID: Int, completion: @escaping (Result<Void>) -> Void)
    func getAccounts(completion: @escaping (Result<[DomainAccountModel]>) -> Void)
}
