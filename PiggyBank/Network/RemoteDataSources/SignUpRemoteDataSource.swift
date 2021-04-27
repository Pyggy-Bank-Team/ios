//
//  SignUpRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct SignUpRemoteDataSource: SignUpDataSource {

    func signUp(request: DomainSignUpModel, completion: @escaping (Result<DomainAuthModel>) -> Void) {
        let requestModel = GrandConverter.convertToRequestModel(domain: request)
        APIManager.shared.perform(request: .SignUp(requestModel)) { (response: Result<UserCredentials.Response>) in
            guard case let .success(responseModel) = response else {
                return completion(.error(APIError()))
            }
            let authModel = GrandConverter.convertToDomainModel(authResponse: responseModel)
            completion(.success((authModel)))
        }
    }
}
