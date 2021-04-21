//
//  DeleteUserCredentialsDataRepository.swift
//  PiggyBank
//

import Foundation

class DeleteUserCredentialsDataRepository: DeleteUserCredentialsRepository {

    private let userDefaults = UserDefaults.standard

    func deleteUserCredentials(completion: @escaping (Result<Void>) -> Void) {
        userDefaults.removeObject(forKey: kCREDENTIALS_STORE_KEY)
        completion(.success(()))
    }
}
