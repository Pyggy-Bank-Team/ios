//
//  SaveUserCredentialsDataRepository.swift
//  PiggyBank
//

import Foundation

class SaveUserCredentialsDataRepository: SaveUserCredentialsRepository {

    private let userDefaults = UserDefaults.standard

    func saveUserCredentials(domainModel: DomainUserCredentialsModel, completion: @escaping (Result<Void>) -> Void) {
        userDefaults.set(domainModel.accessToken, forKey: kCREDENTIALS_STORE_KEY)
        completion(.success(()))
    }
}
