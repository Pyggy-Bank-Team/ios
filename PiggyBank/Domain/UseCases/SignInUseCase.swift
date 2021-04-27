import Foundation

final class SignInUseCase {

    private let signInRepository: SignInRepository?
    private let saveUserCredentialsRepository: UserCredentialsRepository?
    private let saveUserUseCase: SaveUserCredentialsUseCase?

    init(
        signInRepository: SignInRepository?,
        saveUserCredentialsRepository: UserCredentialsRepository?,
        saveUserUseCase: SaveUserCredentialsUseCase?
    ) {
        self.signInRepository = signInRepository
        self.saveUserCredentialsRepository = saveUserCredentialsRepository
        self.saveUserUseCase = saveUserUseCase
    }

    func execute(domainSignInModel: DomainSignInModel, completion: @escaping (Result<Void>) -> Void) {
        signInRepository?.signIn(request: domainSignInModel) { [weak self] result in
            guard let self = self else {
                return completion(.error(APIError()))
            }
            
            guard case let .success(model) = result else {
                return completion(.error(APIError()))
            }
            
            let credentialsModel = DomainUserCredentialsModel(
                accessToken: model.accessToken
            )
            
            self.saveUserUseCase?.execute(domainModel: credentialsModel, completion: completion)
        }
    }

}
