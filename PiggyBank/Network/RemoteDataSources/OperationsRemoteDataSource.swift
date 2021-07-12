//
//  OperationsRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct OperationsRemoteDataSource: OperationsDataSource {

    func getOperations(completion: @escaping (Result<[DomainOperationModel]>) -> Void) {
        APIManager.shared.perform(request: .GetOperations) { (response: Result<Paginated.Response<Operation.Response>>) in
            guard let responseModel = response.value else {
                return completion(.error(response.error ?? InternalError(string: "Cannot get responseModel for GetOperations")))
            }
            let categories = responseModel.result.map { GrandConverter.convertToDomain(response: $0) }
            completion(.success(categories))
        }
    }

    func deleteBudgetOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void) {
        APIManager.shared.perform(request: .DeleteBudgetOperation(operationID), completion: completion)
    }

    func deleteTransferOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void) {
        APIManager.shared.perform(request: .DeleteTransferOperation(operationID), completion: completion)
    }

    func deletePlanOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void) {
        APIManager.shared.perform(request: .DeletePlanOperation(operationID), completion: completion)
    }

    func createTransferOperation(
        request: DomainCreateUpdateTransferOperationModel,
        completion: @escaping (Result<Void>) -> Void
    ) {
        let requestModel = GrandConverter.convertToRequestModel(domain: request)
        APIManager.shared.perform(request: .CreateTransferOperation(requestModel), completion: completion)
    }
}
