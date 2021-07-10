import Foundation

final class ChangeAndUpdateAccountsUseCase {
    
    private let createUpdateAccountUseCase: CreateUpdateAccountUseCase
    private let getAccountsUseCase: GetAccountsUseCase

    init(createUpdateAccountUseCase: CreateUpdateAccountUseCase, getAccountsUseCase: GetAccountsUseCase) {
        self.createUpdateAccountUseCase = createUpdateAccountUseCase
        self.getAccountsUseCase = getAccountsUseCase
    }
    
    func execute(category: DomainAccountModel, completion: @escaping (Result<[DomainAccountModel]>) -> Void) {
        DispatchQueue.global().async { [weak self] in
            self?.createUpdateAccountUseCase.execute(request: category) { [weak self] _ in
                self?.getAccountsUseCase.execute(completion: completion)
            }
        }
    }
    
}
