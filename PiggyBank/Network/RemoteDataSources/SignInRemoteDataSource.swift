//
//  SignInRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct SignInRemoteDataSource: SignInDataSource {

    func signIn(request: DomainSignInModel, completion: @escaping (Result<DomainAuthModel>) -> Void) {
        let requestModel = GrandConverter.convertToRequestModel(domain: request)
        APIManager.shared.perform(request: .SignIn(requestModel)) { (response: Result<UserCredentials.Response>) in
            guard case let .success(responseModel) = response else {
                return completion(.error(APIError()))
            }
            let authModel = GrandConverter.convertToDomainModel(authResponse: responseModel)
            APIManager.shared.setToken(token: authModel.accessToken)
            completion(.success((authModel)))
        }
    }
}
