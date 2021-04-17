import Foundation

final class DeleteUserCredentialsUseCase {
    
    private let userDefaults = UserDefaults.standard
    
    func execute(completion: @escaping (Result<Void>) -> Void) {
        userDefaults.removeObject(forKey: kCREDENTIALS_STORE_KEY)
        completion(.success(()))
    }

}
