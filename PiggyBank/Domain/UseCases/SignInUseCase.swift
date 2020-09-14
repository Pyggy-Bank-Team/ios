import Foundation

final class SignInUseCase {
    
    private let apiManager = APIManager.shared
    private let saveUserUseCase = SaveUserCredentialsUseCase()
    
    func execute(domainSignInModel: DomainSignInModel, completion: @escaping (Result<Void>) -> Void) {
        apiManager.signIn(request: domainSignInModel) { [weak self] result in
            guard let self = self else {
                return completion(.error(APIError()))
            }
            
            guard case let .success(model) = result else {
                return completion(.error(APIError()))
            }
            
            let credentialsModel = DomainUserCredentialsModel(
                nickname: domainSignInModel.nickname,
                accessToken: model.accessToken,
                refreshToken: model.refreshToken
            )
            
            self.saveUserUseCase.execute(domainModel: credentialsModel, completion: completion)
        }
    }

}
