//
//  SignInRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct SignInRemoteDataSource: SignInDataSource {

    func signIn(request: DomainSignInModel, completion: @escaping (Result<DomainAuthModel>) -> Void) {
        let requestModel = GrandConverter.convertToRequestModel(domain: request)
        APIManager.shared.perform(request: .SignIn(requestModel)) { (response: Result<UserCredentials.Response>) in
            guard let responseModel = response.value else {
                return completion(.error(response.error ?? InternalError(string: "Cannot get responseModel for SignIn")))
            }
            let authModel = GrandConverter.convertToDomainModel(authResponse: responseModel)
            APIManager.shared.setToken(token: authModel.accessToken)
            completion(.success((authModel)))
        }
    }
}
