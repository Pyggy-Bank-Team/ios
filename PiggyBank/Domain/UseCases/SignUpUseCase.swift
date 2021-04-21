import Foundation

protocol SignUpRepository {
    func signUp(request: DomainSignUpModel, completion: @escaping (Result<DomainAuthModel>) -> Void)
}

final class SignUpUseCase {

    private let signUpRepository: SignUpRepository
    private let saveUserCredentialsRepository: SaveUserCredentialsRepository
    private lazy var saveUserUseCase = SaveUserCredentialsUseCase(saveUserCredentialsRepository: saveUserCredentialsRepository)

    init(signUpRepository: SignUpRepository, saveUserCredentialsRepository: SaveUserCredentialsRepository) {
        self.signUpRepository = signUpRepository
        self.saveUserCredentialsRepository = saveUserCredentialsRepository
    }

    func execute(domainSignUpModel: DomainSignUpModel, completion: @escaping (Result<Void>) -> Void) {
        signUpRepository.signUp(request: domainSignUpModel) { [weak self] result in
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
