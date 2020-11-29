import Foundation

final class GetUserCredentialsUseCase {
    
    private let userDefaults = UserDefaults.standard
    
    func execute(completion: @escaping (Result<DomainUserCredentialsModel?>) -> Void) {
        guard let token = userDefaults.string(forKey: CREDENTIALS_STORE_KEY) else {
            return completion(.success(nil))
        }

        let model = DomainUserCredentialsModel(accessToken: token)
        completion(.success((model)))
    }

}
