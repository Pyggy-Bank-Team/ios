import Foundation

final class SignUpUseCase {

    private let signUpRepository: SignUpRepository?
    private let saveUserCredentialsRepository: UserCredentialsRepository?
    private let saveUserUseCase: SaveUserCredentialsUseCase?

    init(
        signUpRepository: SignUpRepository,
        saveUserCredentialsRepository: UserCredentialsRepository,
        saveUserUseCase: SaveUserCredentialsUseCase
    ) {
        self.signUpRepository = signUpRepository
        self.saveUserCredentialsRepository = saveUserCredentialsRepository
        self.saveUserUseCase = saveUserUseCase
    }

    func execute(domainSignUpModel: DomainSignUpModel, completion: @escaping (Result<Void>) -> Void) {
        signUpRepository?.signUp(request: domainSignUpModel) { [weak self] result in
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
