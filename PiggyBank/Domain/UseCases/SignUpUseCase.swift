import Foundation

final class SignUpUseCase {
    
    private let apiManager = APIManager.shared
    private let saveUserUseCase = SaveUserCredentialsUseCase()
    
    func execute(domainSignUpModel: DomainSignUpModel, completion: @escaping (Result<Void>) -> Void) {
        apiManager.signUp(request: domainSignUpModel) { [weak self] result in
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
