import Foundation

final class BaseCurrencyPresenter {
    
    private var currencies: [DomainCurrencyModel] = []
    private let getCurrenciesUseCase: GetCurrenciesUseCase
    weak var view: BaseCurrencyViewController?
    
    init(
        view: BaseCurrencyViewController?,
        getCurrenciesUseCase: GetCurrenciesUseCase
    ) {
        self.view = view
        self.getCurrenciesUseCase = getCurrenciesUseCase
    }

    func loadCurrencies() {
        getCurrenciesUseCase.execute { [weak self] result in
            guard let self = self else {
                return
            }
            
            if case let .success(currenciesDomainModels) = result {
                self.currencies = currenciesDomainModels
                
                let currenciesViewModels = currenciesDomainModels.map { GrandConverter.convertToViewModel(domainCurrency: $0) }

                var initialIndex = 0
                if let storedCurrencyData = UserDefaults.standard.object(forKey: "selectedCurrency") as? Data,
                   let storedCurrencyData = try? JSONDecoder().decode(DomainCurrencyModel.self, from: storedCurrencyData) {
                    initialIndex = self.currencies.firstIndex { storedCurrencyData.code == $0.code } ?? 0
                }

                DispatchQueue.main.async {
                    self.view?.loadCurrencies(currencies: currenciesViewModels, initialIndex: initialIndex)
                }
            }
        }
    }
    
    func onDone(index: Int) {
        if let currency = try? JSONEncoder().encode(currencies[index]) {
            UserDefaults.standard.set(currency, forKey: "selectedCurrency")
        }
        view?.navigationController?.popViewController(animated: true)
    }
    
}
