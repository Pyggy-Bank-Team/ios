import Foundation

final class BaseCurrencyPresenter {
    
    private var currencies: [DomainCurrencyModel] = []
    
    private let getCurrenciesUseCase = GetCurrenciesUseCase()
    
    weak var view: BaseCurrencyViewController?
    
    init(view: BaseCurrencyViewController?) {
        self.view = view
    }
    
    func loadCurrencies() {
        getCurrenciesUseCase.execute { [weak self] result in
            guard let self = self else { return }
            
            if case let .success(currenciesDomainModels) = result {
                self.currencies = currenciesDomainModels
                
                let currenciesViewModels = currenciesDomainModels.map { GrandConverter.convertToViewModel(domainCurrency: $0) }
                
                DispatchQueue.main.async {
                    self.view?.loadCurrencies(currencies: currenciesViewModels)
                }
            }
        }
    }
    
}
