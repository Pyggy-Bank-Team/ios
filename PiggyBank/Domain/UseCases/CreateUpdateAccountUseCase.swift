import Foundation

final class CreateUpdateAccountUseCase {
    
    private let apiManager = APIManager.shared
    
    func execute(newAccount: DomainAccountModel, original: DomainAccountModel?, completion: @escaping (Result<Void>) -> Void) {
        
    }

}
