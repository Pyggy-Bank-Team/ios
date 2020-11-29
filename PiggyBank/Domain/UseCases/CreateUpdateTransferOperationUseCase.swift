import Foundation

final class CreateUpdateTransferOperationUseCase {

    private let apiManager = APIManager.shared

    func execute(request: DomainCreateUpdateTransferOperationModel, completion: @escaping (Result<Void>) -> Void) {
        apiManager.createTransferOperation(request: request, completion: completion)
    }

}
