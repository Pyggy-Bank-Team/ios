import Foundation

final class DeleteUserCredentialsUseCase {

    private let deleteUserCredentialsRepository: UserCredentialsRepository?
    
    init(deleteUserCredentialsRepository: UserCredentialsRepository?) {
        self.deleteUserCredentialsRepository = deleteUserCredentialsRepository
    }

    func execute(completion: @escaping (Result<Void>) -> Void) {
        deleteUserCredentialsRepository?.deleteUserCredentials(completion: completion)
    }

}
