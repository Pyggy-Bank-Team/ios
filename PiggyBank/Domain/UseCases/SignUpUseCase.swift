import Foundation

final class SignUpUseCase {

    private let signUpRepository: SignUpRepository?
    private let saveUserUseCase: SaveUserCredentialsUseCase?

    init(
        signUpRepository: SignUpRepository,
        saveUserUseCase: SaveUserCredentialsUseCase
    ) {
        self.signUpRepository = signUpRepository
        self.saveUserUseCase = saveUserUseCase
    }

    func execute(domainSignUpModel: DomainSignUpModel, completion: @escaping (Result<Void>) -> Void) {
        signUpRepository?.signUp(request: domainSignUpModel) { [weak self] result in
            guard let self = self else {
                return completion(.error(InternalError(string: "Cannot get `self`")))
            }

            guard let model = result.value else {
                return completion(.error(result.error ?? InternalError(string: "Cannot get responseModel for signUp")))
            }

            let credentialsModel = DomainUserCredentialsModel(
                accessToken: model.accessToken
            )

            self.saveUserUseCase?.execute(domainModel: credentialsModel, completion: completion)
        }
    }

}
