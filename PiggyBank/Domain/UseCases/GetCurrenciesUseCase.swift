import Foundation

protocol GetCurrenciesRepository {
    func getCurrencies(completion: @escaping (Result<[DomainCurrencyModel]>) -> Void)
}

final class GetCurrenciesUseCase {
    
    private let getCurrenciesRepository: GetCurrenciesRepository

    init(getCurrenciesRepository: GetCurrenciesRepository) {
        self.getCurrenciesRepository = getCurrenciesRepository
    }

    func execute(completion: @escaping (Result<[DomainCurrencyModel]>) -> Void) {
        getCurrenciesRepository.getCurrencies(completion: completion)
    }

}
