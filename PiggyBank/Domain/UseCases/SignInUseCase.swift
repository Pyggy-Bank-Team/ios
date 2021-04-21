import Foundation

protocol SignInRepository {
    func signIn(request: DomainSignInModel, completion: @escaping (Result<DomainAuthModel>) -> Void)
}

final class SignInUseCase {

    private let signInRepository: SignInRepository
    private let saveUserCredentialsRepository: SaveUserCredentialsRepository
    private lazy var saveUserUseCase = SaveUserCredentialsUseCase(saveUserCredentialsRepository: saveUserCredentialsRepository)

    init(signInRepository: SignInRepository, saveUserCredentialsRepository: SaveUserCredentialsRepository) {
        self.signInRepository = signInRepository
        self.saveUserCredentialsRepository = saveUserCredentialsRepository
    }

    func execute(domainSignInModel: DomainSignInModel, completion: @escaping (Result<Void>) -> Void) {
        signInRepository.signIn(request: domainSignInModel) { [weak self] result in
            guard let self = self else {
                return completion(.error(APIError()))
            }
            
            guard case let .success(model) = result else {
                return completion(.error(APIError()))
            }
            
            let credentialsModel = DomainUserCredentialsModel(
                accessToken: model.accessToken
            )
            
            self.saveUserUseCase.execute(domainModel: credentialsModel, completion: completion)
        }
    }

}
