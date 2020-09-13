import Foundation

final class GetCurrenciesUseCase {
    
    private let apiManager = APIManager.shared
    
    func execute(completion: @escaping (Result<[DomainCurrencyModel]>) -> Void) {
        apiManager.getCurrencies(completion: completion)
    }

}
