//
//  GetUserCredentialsDataRepository.swift
//  PiggyBank
//

import Foundation

class GetUserCredentialsDataRepository: GetUserCredentialsRepository {

    private let userDefaults = UserDefaults.standard

    func getUserCredentials(completion: @escaping (Result<DomainUserCredentialsModel?>) -> Void) {
        guard let token = userDefaults.string(forKey: kCREDENTIALS_STORE_KEY) else {
            return completion(.success(nil))
        }
        let model = DomainUserCredentialsModel(accessToken: token)
        completion(.success((model)))
    }
}
