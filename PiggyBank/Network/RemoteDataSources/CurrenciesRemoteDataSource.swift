//
//  CurrenciesRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct CurrenciesRemoteDataSource: CurrenciesDataSource {

    func getCurrencies(completion: @escaping (Result<[DomainCurrencyModel]>) -> Void) {
        APIManager.shared.perform(request: .GetCurrencies) { (response: Result<[Currency.Response]>) in
            guard let responseModel = response.value else {
                return completion(.error(response.error ?? InternalError(string: "Cannot get responseModel for GetCurrencies")))
            }
            let domainCurrencies = responseModel.map { GrandConverter.convertToDomainModel(currencyResponse: $0) }
            completion(.success(domainCurrencies))
        }
    }
}
