//
//  CreateUpdateAccountRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct CreateUpdateAccountRemoteDataSource: CreateUpdateAccountDataSource {

    func updateAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void) {
        guard let id = request.id else {
            fatalError("APIManager: updateAccount - ID can't be null")
        }

        guard let url = URL(string: APIManager.shared.baseURL + "/api/Accounts/\(id)") else {
            return
        }

        let requestModel = GrandConverter.convertToRequestModel(domain: request)

        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(APIManager.shared.token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "PATCH"
        urlRequst.httpBody = try? JSONEncoder().encode(requestModel)
        urlRequst.addValue("application/json", forHTTPHeaderField: "Content-Type")

        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession
            .shared
            .dataTask(with: urlRequst) { _, response, error in
                print("LOGGER: Finish for \(urlRequst.url!)")

                guard let httpResponse = response as? HTTPURLResponse else {
                    return completion(.error(APIError()))
                }

                if httpResponse.statusCode == 200 {
                    completion(.success(()))
                } else {
                    completion(.error(APIError()))
                }
            }
            .resume()
    }

    func createAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: APIManager.shared.baseURL + "/api/Accounts") else {
            return
        }

        let requestModel = GrandConverter.convertToRequestModel(domain: request)

        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(APIManager.shared.token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "POST"
        urlRequst.httpBody = try? JSONEncoder().encode(requestModel)
        urlRequst.addValue("application/json", forHTTPHeaderField: "Content-Type")

        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession
            .shared
            .dataTask(with: urlRequst) { _, response, error in
                print("LOGGER: Finish for \(urlRequst.url!)")

                guard let httpResponse = response as? HTTPURLResponse else {
                    return completion(.error(APIError()))
                }

                if httpResponse.statusCode == 200 {
                    completion(.success(()))
                } else {
                    completion(.error(APIError()))
                }
            }
            .resume()
    }
}
