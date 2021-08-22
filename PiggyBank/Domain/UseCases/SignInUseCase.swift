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
                return completion(.error(InternalError(string: "Cannot get `self`")))
            }
            
            guard let model = result.value else {
                return completion(.error(result.error ?? InternalError(string: "Cannot get responseModel for signIn")))
            }

            let credentialsModel = DomainUserCredentialsModel(
                accessToken: model.accessToken
            )
            
            self.saveUserUseCase?.execute(domainModel: credentialsModel, completion: completion)
        }
    }

}
