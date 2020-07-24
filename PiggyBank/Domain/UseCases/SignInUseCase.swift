import Foundation

final class SignInUseCase: UseCase<UseCasesDTOs.SignIn.Request, UseCasesDTOs.SignIn.Response> {
    
    private let apiManager = APIManager.shared
    
    override func execute(request: UseCasesDTOs.SignIn.Request, completion: @escaping (UseCasesDTOs.SignIn.Response) -> Void) {
        let apiDTO = APIDTOs.SignIn.Request(
            client_id: "client",
            username: request.username,
            password: request.password,
            client_secret: "secret",
            scope: "api1 offline_access",
            grant_type: "password"
        )
        
        apiManager.signIn(request: apiDTO) { response in
            completion(.init(result: response.result))
        }
    }

}
