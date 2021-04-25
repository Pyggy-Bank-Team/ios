//
//  DeleteAccountDataRepository.swift
//  PiggyBank
//

protocol DeleteAccountDataSource {
    func deleteAccount(accountID: Int, completion: @escaping (Result<Void>) -> Void)
}

class DeleteAccountDataRepository: DeleteAccountRepository {

    private let remoteDataSource: DeleteAccountDataSource?

    init(remoteDataSource: DeleteAccountDataSource?) {
        self.remoteDataSource = remoteDataSource
    }

    func deleteAccount(accountID: Int, completion: @escaping (Result<Void>) -> Void) {
        remoteDataSource?.deleteAccount(accountID: accountID, completion: completion)
    }
}
