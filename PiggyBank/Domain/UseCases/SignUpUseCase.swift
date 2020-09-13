import Foundation

final class SignUpUseCase {
    
    private let apiManager = APIManager.shared
    
    func execute(domainSignUpModel: DomainSignUpModel, completion: @escaping (Result<Void>) -> Void) {
        let apiDTO = APIDTOs.SignUp.Request(
            userName: domainSignUpModel.nickname,
            password: domainSignUpModel.password,
            currencyBase: domainSignUpModel.currency
        )
        
        apiManager.signUp(request: apiDTO) { result in
            completion(result.result)
        }
    }

}
