//
//  DeleteOperationDataRepository.swift
//  PiggyBank
//

protocol DeleteOperationDataSource {
    func deleteBudgetOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void)
    func deleteTransferOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void)
    func deletePlanOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void)
}

class DeleteOperationDataRepository: DeleteOperationRepository {

    private let remoteDataSource: DeleteOperationDataSource?

    init(remoteDataSource: DeleteOperationDataSource?) {
        self.remoteDataSource = remoteDataSource
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

}
