import Foundation

final class SaveUserCredentialsUseCase {
    
    private let userDefaults = UserDefaults.standard
    
    func execute(domainModel: DomainUserCredentialsModel, completion: @escaping (Result<Void>) -> Void) {
        userDefaults.set(domainModel.accessToken, forKey: kCREDENTIALS_STORE_KEY)
        completion(.success(()))
    }

}
