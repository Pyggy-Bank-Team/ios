import Foundation

final class GetOperationsUseCase {
    
    private let getOperationsRepository: OperationsRepository?

    init(getOperationsRepository: OperationsRepository?) {
        self.getOperationsRepository = getOperationsRepository
    }

    func execute(completion: @escaping (Result<[DomainOperationModel]>) -> Void) {
        getOperationsRepository?.getOperations(completion: completion)
    }

}
