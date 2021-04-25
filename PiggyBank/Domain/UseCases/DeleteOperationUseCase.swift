import Foundation

protocol DeleteOperationRepository {
    func deleteBudgetOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void)
    func deleteTransferOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void)
    func deletePlanOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void)
}

final class DeleteOperationUseCase {
    
    private let deleteOperationRepository: DeleteOperationRepository

    init(deleteOperationRepository: DeleteOperationRepository) {
        self.deleteOperationRepository = deleteOperationRepository
    }

    func execute(operation: DomainOperationModel, completion: @escaping (Result<Void>) -> Void) {
        switch operation.type {
        case .budget:
            deleteOperationRepository.deleteBudgetOperation(operationID: operation.id, completion: completion)
        case .transfer:
            deleteOperationRepository.deleteTransferOperation(operationID: operation.id, completion: completion)
        case .plan:
            deleteOperationRepository.deletePlanOperation(operationID: operation.id, completion: completion)
        default:
            break
        }
    }

}
