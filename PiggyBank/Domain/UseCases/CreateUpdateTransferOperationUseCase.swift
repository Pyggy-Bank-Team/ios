import Foundation

protocol CreateUpdateTransferOperationRepository {
    func createTransferOperation(
        request: DomainCreateUpdateTransferOperationModel,
        completion: @escaping (Result<Void>) -> Void
    )
}

final class CreateUpdateTransferOperationUseCase {

    private let createUpdateTransferOperationRepository: CreateUpdateTransferOperationRepository

    init(createUpdateTransferOperationRepository: CreateUpdateTransferOperationRepository) {
        self.createUpdateTransferOperationRepository = createUpdateTransferOperationRepository
    }

    func execute(request: DomainCreateUpdateTransferOperationModel, completion: @escaping (Result<Void>) -> Void) {
        createUpdateTransferOperationRepository.createTransferOperation(request: request, completion: completion)
    }

}
