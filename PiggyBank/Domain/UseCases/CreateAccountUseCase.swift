import Foundation

final class CreateAccountUseCase: UseCase<UseCasesDTOs.CreateAccount.Request, UseCasesDTOs.CreateAccount.Response> {
    
    private let apiManager = APIManager.shared
    
    override func execute(request: UseCasesDTOs.CreateAccount.Request, completion: @escaping (UseCasesDTOs.CreateAccount.Response) -> Void) {
        apiManager.createAccount(request: .init(title: request.title, type: 0, currency: "RUB", balance: 0)) { response in
            completion(.init(result: response.result))
        }
    }

}
