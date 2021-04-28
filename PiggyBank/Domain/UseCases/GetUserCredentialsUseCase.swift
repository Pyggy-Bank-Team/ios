import Foundation

final class GetUserCredentialsUseCase {
    
    private let getUserCredentialsRepository: UserCredentialsRepository?

    init(getUserCredentialsRepository: UserCredentialsRepository?) {
        self.getUserCredentialsRepository = getUserCredentialsRepository
    }

    func execute(completion: @escaping (Result<DomainUserCredentialsModel?>) -> Void) {
        getUserCredentialsRepository?.getUserCredentials(completion: completion)
    }

}
