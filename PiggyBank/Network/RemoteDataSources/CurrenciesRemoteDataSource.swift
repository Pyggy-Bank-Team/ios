//
//  CurrenciesRemoteDataSource.swift
//  PiggyBank
//

import Foundation

struct CurrenciesRemoteDataSource: CurrenciesDataSource {

    func getCurrencies(completion: @escaping (Result<[DomainCurrencyModel]>) -> Void) {
        APIManager.shared.perform(request: .GetCurrencies) { (response: Result<[Currency.Response]>) in
            guard case let .success(responseModel) = response else {
                return completion(.error(APIError()))
            }
            let domainCurrencies = responseModel.map { GrandConverter.convertToDomainModel(currencyResponse: $0) }
            completion(.success(domainCurrencies))
        }
    }
}
