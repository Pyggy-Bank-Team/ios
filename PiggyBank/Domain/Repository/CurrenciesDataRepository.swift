//
//  CurrenciesDataRepository.swift
//  PiggyBank
//

protocol CurrenciesDataSource {
    func getCurrencies(completion: @escaping (Result<[DomainCurrencyModel]>) -> Void)
}

class CurrenciesDataRepository: CurrenciesRepository {

    private let remoteDataSource: CurrenciesDataSource?

    init(remoteDataSource: CurrenciesDataSource?) {
        self.remoteDataSource = remoteDataSource
    }

    func getCurrencies(completion: @escaping (Result<[DomainCurrencyModel]>) -> Void) {
        remoteDataSource?.getCurrencies(completion: completion)
    }

}
