import Foundation

final class AccountPresenter {
    
    private let accountDomainModel: DomainAccountModel?
    
    private let getCurrenciesUseCase = GetCurrenciesUseCase()
    private let createUpdateAccountUseCase = CreateUpdateAccountUseCase()
    
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
    
    func onSave() {
        guard let view = view else {
            fatalError("AccountPresenter: onSave - view is nil")
        }
        
        let accountCurrency: String
        let accountID: Int?
        
        if let account = accountDomainModel {
            accountCurrency = account.currency
            accountID = account.id
        } else {
            accountCurrency = view.accountCurrency
            accountID = nil
        }
        
        guard let accountType = DomainAccountModel.AccountType(rawValue: view.accountType) else {
            fatalError("AccountPresenter: onSave - account type is invalid")
        }
        
        let accountTitle = view.accountTitle
        let accountBalance = view.accountBalance
        let accountArchive = view.accountArchived
        
        let createUpdateDomain = DomainAccountModel(
            id: accountID,
            type: accountType.rawValue,
            title: accountTitle,
            currency: accountCurrency,
            balance: accountBalance,
            isArchived: accountArchive,
            isDeleted: false
        )
        
        createUpdateAccountUseCase.execute(request: createUpdateDomain) { [weak self] result in
            guard let self = self else { return }
            
            if case .success = result {
                DispatchQueue.main.async {
                    self.view?.accountSaved()
                }
            }
        }
    }
    
}
