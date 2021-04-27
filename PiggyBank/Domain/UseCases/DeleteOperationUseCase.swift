import Foundation

final class DeleteOperationUseCase {
    
    private let deleteOperationRepository: OperationsRepository?

    init(deleteOperationRepository: OperationsRepository?) {
        self.deleteOperationRepository = deleteOperationRepository
    }

    func execute(operation: DomainOperationModel, completion: @escaping (Result<Void>) -> Void) {
        switch operation.type {
        case .budget:
            deleteOperationRepository?.deleteBudgetOperation(operationID: operation.id, completion: completion)
        case .transfer:
            deleteOperationRepository?.deleteTransferOperation(operationID: operation.id, completion: completion)
        case .plan:
            deleteOperationRepository?.deletePlanOperation(operationID: operation.id, completion: completion)
        default:
            break
        }
    }
}
