//
//  GetCurrenciesDataRepository.swift
//  PiggyBank
//

protocol GetCurrenciesDataSource {
    func getCurrencies(completion: @escaping (Result<[DomainCurrencyModel]>) -> Void)
}

class GetCurrenciesDataRepository: GetCurrenciesRepository {

    private let remoteDataSource: GetCurrenciesDataSource

    init(remoteDataSource: GetCurrenciesDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getCurrencies(completion: @escaping (Result<[DomainCurrencyModel]>) -> Void) {
        remoteDataSource.getCurrencies(completion: completion)
    }

}
