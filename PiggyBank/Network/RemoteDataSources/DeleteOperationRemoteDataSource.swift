//
//  DeleteOperationRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct DeleteOperationRemoteDataSource: DeleteOperationDataSource {

    func deleteBudgetOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: APIManager.shared.baseURL + "/api/Operations/Budget/\(operationID)") else {
            return
        }

        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(APIManager.shared.token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "DELETE"

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

    func deleteTransferOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: APIManager.shared.baseURL + "/api/Operations/Transfer/\(operationID)") else {
            return
        }

        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(APIManager.shared.token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "DELETE"

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

    func deletePlanOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: APIManager.shared.baseURL + "/api/Operations/Plan/\(operationID)") else {
            return
        }

        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(APIManager.shared.token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "DELETE"

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
