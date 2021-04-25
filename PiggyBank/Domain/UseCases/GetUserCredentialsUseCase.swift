import Foundation

protocol GetUserCredentialsRepository {
    func getUserCredentials(completion: @escaping (Result<DomainUserCredentialsModel?>) -> Void)
}

final class GetUserCredentialsUseCase {
    
    private let getUserCredentialsRepository: GetUserCredentialsRepository?

    init(getUserCredentialsRepository: GetUserCredentialsRepository?) {
        self.getUserCredentialsRepository = getUserCredentialsRepository
    }

    func execute(completion: @escaping (Result<DomainUserCredentialsModel?>) -> Void) {
        getUserCredentialsRepository?.getUserCredentials(completion: completion)
    }

}
