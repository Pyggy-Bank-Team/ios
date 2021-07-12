//
//  SignUpRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct SignUpRemoteDataSource: SignUpDataSource {

    func signUp(request: DomainSignUpModel, completion: @escaping (Result<DomainAuthModel>) -> Void) {
        let requestModel = GrandConverter.convertToRequestModel(domain: request)
        APIManager.shared.perform(request: .SignUp(requestModel)) { (response: Result<UserCredentials.Response>) in
            guard let responseModel = response.value else {
                return completion(.error(response.error ?? InternalError(string: "Cannot get responseModel for SignUp")))
            }
            let authModel = GrandConverter.convertToDomainModel(authResponse: responseModel)
            completion(.success((authModel)))
        }
    }
}
