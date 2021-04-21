import Foundation

protocol DeleteUserCredentialsRepository {
    func deleteUserCredentials(completion: @escaping (Result<Void>) -> Void)
}

final class DeleteUserCredentialsUseCase {

    private let deleteUserCredentialsRepository: DeleteUserCredentialsRepository
    
    init(deleteUserCredentialsRepository: DeleteUserCredentialsRepository) {
        self.deleteUserCredentialsRepository = deleteUserCredentialsRepository
    }

    func execute(completion: @escaping (Result<Void>) -> Void) {
        deleteUserCredentialsRepository.deleteUserCredentials(completion: completion)
    }

}
