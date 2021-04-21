//
//  GetOperationsRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct GetOperationsRemoteDataSource: GetOperationsDataSource {

    func getOperations(completion: @escaping (Result<[DomainOperationModel]>) -> Void) {
        guard var components = URLComponents(string: APIManager.shared.baseURL + "/api/Operations") else {
            return
        }

        components.queryItems = [
            URLQueryItem(name: "all", value: "true")
        ]

        var urlRequst = URLRequest(url: components.url!)
        urlRequst.setValue("Bearer \(APIManager.shared.token)", forHTTPHeaderField: "Authorization")

        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession
            .shared
            .dataTask(with: urlRequst) { data, response, error in
                print("LOGGER: Finish for \(urlRequst.url!)")

                guard let data = data,
                      let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    return completion(.error(APIError()))
                }

                do {
                    let model = try JSONDecoder().decode(Paginated.Response<Operation.Response>.self, from: data)
                    let categories = model.result.map { GrandConverter.convertToDomain(response: $0) }
                    completion(.success(categories))
                } catch {
                    print("decode error: \(error)")
                    assertionFailure("getOperations decode error")
                    return completion(.error(APIError()))
                }
            }
            .resume()
    }
}
