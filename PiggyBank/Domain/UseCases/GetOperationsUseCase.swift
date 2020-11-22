import Foundation

final class GetOperationsUseCase {
    
    private let apiManager = APIManager.shared
    
    func execute(completion: @escaping (Result<[DomainOperationModel]>) -> Void) {
        apiManager.getOperations(completion: completion)
    }

}
