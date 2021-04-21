//
//  SignInRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct SignInRemoteDataSource: SignInDataSource {

    func signIn(request: DomainSignInModel, completion: @escaping (Result<DomainAuthModel>) -> Void) {
        guard let url = URL(string: APIManager.shared.baseURL + "/api/tokens/connect") else {
            return
        }

        let requestModel = GrandConverter.convertToRequestModel(domain: request)

        var urlRequst = URLRequest(url: url)
        urlRequst.httpMethod = "POST"
        urlRequst.httpBody = try? JSONEncoder().encode(requestModel)
        urlRequst.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession
            .shared
            .dataTask(with: urlRequst) { data, response, error in
                guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                    return completion(.error(APIError()))
                }

                if httpResponse.statusCode == 200 {
                    guard let response = try? JSONDecoder().decode(UserCredentials.Response.self, from: data) else {
                        return completion(.error(APIError()))
                    }
                    let authModel = GrandConverter.convertToDomainModel(authResponse: response)
                    APIManager.shared.setToken(token: authModel.accessToken)
                    completion(.success(authModel))
                } else {
                    completion(.error(APIError()))
                }
            }
            .resume()
    }
}
