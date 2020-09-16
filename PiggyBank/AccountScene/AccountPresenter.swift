import Foundation

final class AccountPresenter {
    
    private let accountDomainModel: DomainAccountModel?
    
    private let getCurrenciesUseCase = GetCurrenciesUseCase()
    
    weak var view: AccountViewController?
    
    init(accountDomainModel: DomainAccountModel?, view: AccountViewController?) {
        self.accountDomainModel = accountDomainModel
        self.view = view
    }
    
    func loadData() {
        let accountViewModel = GrandConverter.convertToViewModel(domainAccount: accountDomainModel)
        view?.loadAccount(account: accountViewModel)
        
        getCurrenciesUseCase.execute { [weak self] result in
            guard let self = self else { return }
            
            if case let .success(currenciesDomainModels) = result {
                let currenciesViewModels = currenciesDomainModels.map { GrandConverter.convertToViewModel(domainCurrency: $0) }
                
                DispatchQueue.main.async {
                    self.view?.loadCurrencies(currencies: currenciesViewModels)
                }
            }
        }
    }
    
}
