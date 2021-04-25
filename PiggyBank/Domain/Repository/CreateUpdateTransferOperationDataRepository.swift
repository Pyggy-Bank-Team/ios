//
//  CreateUpdateTransferOperationDataRepository.swift
//  PiggyBank
//

protocol CreateUpdateTransferOperationDataSource {
    func createTransferOperation(
        request: DomainCreateUpdateTransferOperationModel,
        completion: @escaping (Result<Void>) -> Void
    )
}

class CreateUpdateTransferOperationDataRepository: CreateUpdateTransferOperationRepository {

    private let remoteDataSource: CreateUpdateTransferOperationDataSource?

    init(remoteDataSource: CreateUpdateTransferOperationDataSource?) {
        self.remoteDataSource = remoteDataSource
    }

    func createTransferOperation(
        request: DomainCreateUpdateTransferOperationModel,
        completion: @escaping (Result<Void>) -> Void
    ) {
        remoteDataSource?.createTransferOperation(request: request, completion: completion)
    }
}
