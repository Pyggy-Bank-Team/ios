protocol SaveUserCredentialsRepository {
    func saveUserCredentials(domainModel: DomainUserCredentialsModel, completion: @escaping (Result<Void>) -> Void)
}

final class SaveUserCredentialsUseCase {

    private let saveUserCredentialsRepository: SaveUserCredentialsRepository

    init(saveUserCredentialsRepository: SaveUserCredentialsRepository) {
        self.saveUserCredentialsRepository = saveUserCredentialsRepository
    }

    func execute(domainModel: DomainUserCredentialsModel, completion: @escaping (Result<Void>) -> Void) {
        saveUserCredentialsRepository.saveUserCredentials(domainModel: domainModel, completion: completion)
    }

}
