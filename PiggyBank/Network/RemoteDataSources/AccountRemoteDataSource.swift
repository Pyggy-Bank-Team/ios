//
//  AccountRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct AccountRemoteDataSource: AccountDataSource {

    func updateAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void) {
        guard let id = request.id else {
            fatalError("APIManager: updateAccount - ID can't be null")
        }

        let requestModel = GrandConverter.convertToRequestModel(domain: request)
        APIManager.shared.perform(request: .UpdateAccount(id, requestModel), completion: completion)
    }

    func createAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void) {
        let requestModel = GrandConverter.convertToRequestModel(domain: request)
        APIManager.shared.perform(request: .CreateAccount(requestModel), completion: completion)
    }

    func deleteAccount(accountID: Int, completion: @escaping (Result<Void>) -> Void) {
        APIManager.shared.perform(request: .DeleteAccount(accountID), completion: completion)
    }

    func getAccounts(completion: @escaping (Result<[DomainAccountModel]>) -> Void) {
        APIManager.shared.perform(request: .GetAccounts) { (response: Result<[Account.Response]>) in
            guard let responseModel = response.value else {
                return completion(.error(response.error ?? InternalError(string: "Cannot get responseModel for GetAccounts")))
            }
            let accounts = responseModel.map { GrandConverter.convertToDomain(response: $0) }
            completion(.success(accounts))
        }
    }
}
