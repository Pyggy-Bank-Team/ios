import Foundation

final class DeleteOperationUseCase {
    
    private let apiManager = APIManager.shared
    
    func execute(operation: DomainOperationModel, completion: @escaping (Result<Void>) -> Void) {
        switch operation.type {
        case .budget:
            apiManager.deleteBudgetOperation(operationID: operation.id, completion: completion)
        case .transfer:
            apiManager.deleteTransferOperation(operationID: operation.id, completion: completion)
        case .plan:
            apiManager.deletePlanOperation(operationID: operation.id, completion: completion)
        default:
            break
        }
    }

}
