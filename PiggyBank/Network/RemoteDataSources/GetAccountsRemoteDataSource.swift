//
//  GetAccountsRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct GetAccountsRemoteDataSource: GetAccountsDataSource {

    func getAccounts(completion: @escaping (Result<[DomainAccountModel]>) -> Void) {
        guard let url = URL(string: APIManager.shared.baseURL + "/api/Accounts") else {
            return
        }

        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(APIManager.shared.token)", forHTTPHeaderField: "Authorization")

        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession
            .shared
            .dataTask(with: urlRequst) { data, response, error in
                print("LOGGER: Finish for \(urlRequst.url!)")

                guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                    return completion(.error(APIError()))
                }

                if httpResponse.statusCode == 200 {
                    guard let model = try? JSONDecoder().decode([Account.Response].self, from: data) else {
                        return completion(.error(APIError()))
                    }

                    let accounts = model.map { GrandConverter.convertToDomain(response: $0) }
                    completion(.success(accounts))
                } else {
                    completion(.error(APIError()))
                }
            }
            .resume()
    }
}
