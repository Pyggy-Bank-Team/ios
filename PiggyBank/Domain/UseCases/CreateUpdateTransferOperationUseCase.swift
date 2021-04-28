import Foundation

final class CreateUpdateTransferOperationUseCase {

    private let createUpdateTransferOperationRepository: OperationsRepository?

    init(createUpdateTransferOperationRepository: OperationsRepository?) {
        self.createUpdateTransferOperationRepository = createUpdateTransferOperationRepository
    }

    func execute(request: DomainCreateUpdateTransferOperationModel, completion: @escaping (Result<Void>) -> Void) {
        createUpdateTransferOperationRepository?.createTransferOperation(request: request, completion: completion)
    }

}
