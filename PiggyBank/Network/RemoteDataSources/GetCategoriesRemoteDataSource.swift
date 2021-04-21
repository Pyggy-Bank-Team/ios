//
//  GetCategoriesRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct GetCategoriesRemoteDataSource: GetCategoriesDataSource {

    func getCategories(completion: @escaping (Result<[DomainCategoryModel]>) -> Void) {
        guard let url = URL(string: APIManager.shared.baseURL + "/api/Categories") else {
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
                    guard let model = try? JSONDecoder().decode([Category.Response].self, from: data) else {
                        return completion(.error(APIError()))
                    }

                    let categories = model.map { GrandConverter.convertToDomain(response: $0) }

                    completion(.success(categories))
                } else {
                    completion(.error(APIError()))
                }
            }
            .resume()
    }
}
