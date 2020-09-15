import Foundation

final class ArchiveAccountUseCase {
    
    private let apiManager = APIManager.shared
    
    func execute(accountID: Int, isArchived: Bool, completion: @escaping (Result<Void>) -> Void) {
        let domainModel = DomainArchiveAccountModel(id: accountID, isArchived: isArchived)
        
        apiManager.archiveAccount(request: domainModel, completion: completion)
    }

}
