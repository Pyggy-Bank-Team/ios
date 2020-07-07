import Foundation

typealias DTO = UseCasesDTOs.SignUp

final class SignUpUseCase: UseCase<DTO.Request, DTO.Response> {
    
    private let apiManager = APIManager()
    
    override func execute(request: DTO.Request, completion: @escaping (DTO.Response) -> Void) {
        let apiDTO = APIDTOs.SignUp.Request(userName: request.username, password: request.password)
        
        apiManager.signUp(request: apiDTO) { result in
            completion(.init(result: result))
        }
    }

}
