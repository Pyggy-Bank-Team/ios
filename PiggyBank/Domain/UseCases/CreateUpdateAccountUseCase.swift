import Foundation

protocol CreateUpdateAccountRepository {
    func createAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void)
    func updateAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void)
}

final class CreateUpdateAccountUseCase {

    private let createUpdateAccountRepository: CreateUpdateAccountRepository?

    init(createUpdateAccountRepository: CreateUpdateAccountRepository?) {
        self.createUpdateAccountRepository = createUpdateAccountRepository
    }

    func execute(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void) {
        if request.id != nil {
            createUpdateAccountRepository?.updateAccount(request: request, completion: completion)
        } else {
            createUpdateAccountRepository?.createAccount(request: request, completion: completion)
        }
    }

}
