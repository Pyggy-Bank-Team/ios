import Foundation

final class GetUserCredentialsUseCase {
    
    private let userDefaults = UserDefaults.standard
    
    func execute(completion: @escaping (Result<DomainUserCredentialsModel?>) -> Void) {
        guard let data = userDefaults.data(forKey: CREDENTIALS_STORE_KEY) else {
            return completion(.success(nil))
        }
        
        guard let model = try? JSONDecoder().decode(DomainUserCredentialsModel.self, from: data) else {
            return completion(.error(APIError()))
        }
        
        completion(.success((model)))
    }

}
