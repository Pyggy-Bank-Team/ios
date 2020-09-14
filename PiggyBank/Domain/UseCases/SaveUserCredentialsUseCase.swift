import Foundation

final class SaveUserCredentialsUseCase {
    
    private let userDefaults = UserDefaults.standard
    
    func execute(domainModel: DomainUserCredentialsModel, completion: @escaping (Result<Void>) -> Void) {
        let jsonEncoder = JSONEncoder()
        
        guard let storeData = try? jsonEncoder.encode(domainModel) else {
            return completion(.error(APIError()))
        }
        
        userDefaults.set(storeData, forKey: CREDENTIALS_STORE_KEY)
        completion(.success(()))
    }

}
