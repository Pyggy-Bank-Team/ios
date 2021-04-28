//
//  OperationsRepository.swift
//  PiggyBank
//

protocol OperationsRepository {
    func getOperations(completion: @escaping (Result<[DomainOperationModel]>) -> Void)
    func deleteBudgetOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void)
    func deleteTransferOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void)
    func deletePlanOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void)
    func createTransferOperation(
        request: DomainCreateUpdateTransferOperationModel,
        completion: @escaping (Result<Void>) -> Void
    )
}
