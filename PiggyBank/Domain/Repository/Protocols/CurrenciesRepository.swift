//
//  CurrenciesRepository.swift
//  PiggyBank
//

protocol CurrenciesRepository {
    func getCurrencies(completion: @escaping (Result<[DomainCurrencyModel]>) -> Void)
}
