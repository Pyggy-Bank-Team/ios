//
//  UserCredentialsDataRepository.swift
//  PiggyBank
//

import Foundation

class UserCredentialsDataRepository: UserCredentialsRepository {

    private let userDefaults = UserDefaults.standard

    func saveUserCredentials(domainModel: DomainUserCredentialsModel, completion: @escaping (Result<Void>) -> Void) {
        userDefaults.set(domainModel.accessToken, forKey: kCREDENTIALS_STORE_KEY)
        completion(.success(()))
    }

    func deleteUserCredentials(completion: @escaping (Result<Void>) -> Void) {
        userDefaults.removeObject(forKey: kCREDENTIALS_STORE_KEY)
        completion(.success(()))
    }

    func getUserCredentials(completion: @escaping (Result<DomainUserCredentialsModel?>) -> Void) {
        guard let token = userDefaults.string(forKey: kCREDENTIALS_STORE_KEY) else {
            return completion(.success(nil))
        }
        let model = DomainUserCredentialsModel(accessToken: token)
        completion(.success((model)))
    }
}
