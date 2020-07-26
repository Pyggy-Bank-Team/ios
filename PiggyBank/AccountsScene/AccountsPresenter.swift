import Foundation

final class AccountsPresenter {
    
    private weak var view: AccountsViewController?
    
    private let getAccountsUseCase = GetAccountsUseCase()
    private let createAccountUseCase = CreateAccountUseCase()
    
    init(view: AccountsViewController) {
        self.view = view
    }
    
    func onViewDidLoad(request: AccountsDTOs.ViewDidLoad.Request) {
        view?.viewDidLoad(response: .init(title: "Accounts"))
        
        getAccountsUseCase.execute(request: .init()) { [weak self] response in
            DispatchQueue.main.async {
                if case let .success(items) = response.result {
                    let result = items.map {
                        AccountsDTOs.ViewDidLoad.Response.Accounts.Account(title: $0.title, currency: $0.currency, total: $0.balance, isArchived: $0.isArchived)
                    }
                    
                    self?.view?.viewDidLoad(response: .init(accounts: result))
                }
            }
        }
    }
    
    func onAddAccount(request: AccountsDTOs.OnAdd.Request) {
        createAccountUseCase.execute(request: .init(title: request.title)) { response in
            DispatchQueue.main.async {
                if case .success = response.result {
                    self.view?.onAdd(response: .init(title: "Successfully"))
                } else {
                    self.view?.onAdd(response: .init(title: "Error"))
                }
            }
        }
    }
    
}
