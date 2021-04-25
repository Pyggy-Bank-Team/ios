//
//  CreateUpdateTransferOperationRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct CreateUpdateTransferOperationRemoteDataSource: CreateUpdateTransferOperationDataSource {

    func createTransferOperation(
        request: DomainCreateUpdateTransferOperationModel,
        completion: @escaping (Result<Void>) -> Void
    ) {
        guard let url = URL(string: APIManager.shared.baseURL + "/api/Operations/Transfer") else {
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
