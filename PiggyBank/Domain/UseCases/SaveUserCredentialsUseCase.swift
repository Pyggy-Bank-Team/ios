final class SaveUserCredentialsUseCase {

    private let saveUserCredentialsRepository: UserCredentialsRepository?

    init(saveUserCredentialsRepository: UserCredentialsRepository?) {
        self.saveUserCredentialsRepository = saveUserCredentialsRepository
    }

    func execute(domainModel: DomainUserCredentialsModel, completion: @escaping (Result<Void>) -> Void) {
        saveUserCredentialsRepository?.saveUserCredentials(domainModel: domainModel, completion: completion)
    }

}
