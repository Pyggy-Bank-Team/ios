//
//  GetOperationsDataRepository.swift
//  PiggyBank
//

protocol GetOperationsDataSource {
    func getOperations(completion: @escaping (Result<[DomainOperationModel]>) -> Void)
}

class GetOperationsDataRepository: GetOperationsRepository {

    private let remoteDataSource: GetOperationsDataSource

    init(remoteDataSource: GetOperationsDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getOperations(completion: @escaping (Result<[DomainOperationModel]>) -> Void) {
        remoteDataSource.getOperations(completion: completion)
    }
}
