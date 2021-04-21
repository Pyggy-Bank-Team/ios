import Foundation

protocol GetOperationsRepository {
    func getOperations(completion: @escaping (Result<[DomainOperationModel]>) -> Void)
}

final class GetOperationsUseCase {
    
    private let getOperationsRepository: GetOperationsRepository

    init(getOperationsRepository: GetOperationsRepository) {
        self.getOperationsRepository = getOperationsRepository
    }

    func execute(completion: @escaping (Result<[DomainOperationModel]>) -> Void) {
        getOperationsRepository.getOperations(completion: completion)
    }

}
