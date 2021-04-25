//
//  GetReportsByCategoryRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct GetReportsByCategoryRemoteDataSource: GetReportsByCategoryDataSource {

    func getReportsByCategory(
        category: DomainCategoryModel.CategoryType,
        from: Date,
        to: Date,
        completion: @escaping (Result<[DomainCategoryReportModel]>) -> Void
    ) {
        guard let url = URL(string: APIManager.shared.baseURL + "/api/Reports/Chart/byCategories") else {
            return
        }

        let requestModel = GrandConverter.convertToRequestModel(category: category, fromDate: from, toDate: to)
        var urlRequst = URLRequest(url: url)
        urlRequst.httpMethod = "POST"
        urlRequst.httpBody = try? JSONEncoder().encode(requestModel)
        urlRequst.setValue("Bearer \(APIManager.shared.token)", forHTTPHeaderField: "Authorization")
        urlRequst.addValue("application/json", forHTTPHeaderField: "Content-Type")

        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession
            .shared
            .dataTask(with: urlRequst) { data, response, error in
                print("LOGGER: Finish for \(urlRequst.url!)")

                guard let data = data,
                      let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200
                else {
                    return completion(.error(APIError()))
                }
                do {
                    let model = try JSONDecoder().decode([Reports.Response].self, from: data)
                    let operations = model.map { GrandConverter.convertToDomain(response: $0) }
                    completion(.success(operations))
                } catch {
                    print("decode error: \(error)")
                    assertionFailure("getReportsByCategory decode error")
                    return completion(.error(APIError()))
                }
            }
            .resume()
    }
}
