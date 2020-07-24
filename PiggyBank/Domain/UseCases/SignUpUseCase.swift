import Foundation

final class SignUpUseCase: UseCase<UseCasesDTOs.SignUp.Request, UseCasesDTOs.SignUp.Response> {
    
    private let apiManager = APIManager.shared
    
    override func execute(request: UseCasesDTOs.SignUp.Request, completion: @escaping (UseCasesDTOs.SignUp.Response) -> Void) {
        let apiDTO = APIDTOs.SignUp.Request(userName: request.username, password: request.password)
        
        apiManager.signUp(request: apiDTO) { result in
            completion(.init(result: result.result))
        }
    }

}
