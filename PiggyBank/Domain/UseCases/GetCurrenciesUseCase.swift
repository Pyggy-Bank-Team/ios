import Foundation

final class GetCurrenciesUseCase {
    
    private let getCurrenciesRepository: CurrenciesRepository?

    init(getCurrenciesRepository: CurrenciesRepository?) {
        self.getCurrenciesRepository = getCurrenciesRepository
    }

    func execute(completion: @escaping (Result<[DomainCurrencyModel]>) -> Void) {
        getCurrenciesRepository?.getCurrencies(completion: completion)
    }

}
