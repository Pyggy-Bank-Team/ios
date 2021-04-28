//
//  CurrenciesRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct CurrenciesRemoteDataSource: CurrenciesDataSource {

    func getCurrencies(completion: @escaping (Result<[DomainCurrencyModel]>) -> Void) {
        guard let url = URL(string: APIManager.shared.baseURL + "/api/Currencies") else {
            return
        }

        let urlRequst = URLRequest(url: url)

        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession
            .shared
            .dataTask(with: urlRequst) { data, response, error in
                print("LOGGER: Finish for \(urlRequst.url!)")

                guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                    return completion(.error(APIError()))
                }

                if httpResponse.statusCode == 200 {
                    guard let models = try? JSONDecoder().decode([Currency.Response].self, from: data) else {
                        return completion(.error(APIError()))
                    }

                    let domainCurrencies = models.map { GrandConverter.convertToDomainModel(currencyResponse: $0) }

                    completion(.success(domainCurrencies))
                } else {
                    completion(.error(APIError()))
                }
            }
            .resume()
    }
}
