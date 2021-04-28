import Foundation

final class CreateUpdateAccountUseCase {

    private let createUpdateAccountRepository: AccountRepository?

    init(createUpdateAccountRepository: AccountRepository?) {
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
