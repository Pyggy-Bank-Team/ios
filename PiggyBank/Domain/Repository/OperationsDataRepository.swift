//
//  OperationsDataRepository.swift
//  PiggyBank
//

protocol OperationsDataSource {
    func deleteBudgetOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void)
    func deleteTransferOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void)
    func deletePlanOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void)
    func getOperations(completion: @escaping (Result<[DomainOperationModel]>) -> Void)
    func createTransferOperation(
        request: DomainCreateUpdateTransferOperationModel,
        completion: @escaping (Result<Void>) -> Void
    )
}

class OperationsDataRepository: OperationsRepository {

    private let remoteDataSource: OperationsDataSource?

    init(remoteDataSource: OperationsDataSource?) {
        self.remoteDataSource = remoteDataSource
    }

    func getOperations(completion: @escaping (Result<[DomainOperationModel]>) -> Void) {
        remoteDataSource?.getOperations(completion: completion)
    }

    func deleteBudgetOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void) {
        remoteDataSource?.deleteBudgetOperation(operationID: operationID, completion: completion)
    }

    func deleteTransferOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void) {
        remoteDataSource?.deleteTransferOperation(operationID: operationID, completion: completion)
    }

    func deletePlanOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void) {
        remoteDataSource?.deletePlanOperation(operationID: operationID, completion: completion)
    }

    func createTransferOperation(
        request: DomainCreateUpdateTransferOperationModel,
        completion: @escaping (Result<Void>) -> Void
    ) {
        remoteDataSource?.createTransferOperation(request: request, completion: completion)
    }
}
