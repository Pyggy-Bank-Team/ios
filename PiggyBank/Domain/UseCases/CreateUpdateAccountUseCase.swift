import Foundation

final class CreateUpdateAccountUseCase {
    
    private let apiManager = APIManager.shared
    
    func execute(request: DomainCreateUpdateAccountModel, completion: @escaping (Result<Void>) -> Void) {
        if request.id != nil {
            apiManager.updateAccount(request: request, completion: completion)
        } else {
            apiManager.createAccount(request: request, completion: completion)
        }
    }

}
