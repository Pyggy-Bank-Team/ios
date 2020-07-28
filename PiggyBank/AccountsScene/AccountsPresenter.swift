import Foundation

final class AccountsPresenter {
    
    private weak var view: AccountsViewController?
    
    private let getAccountsUseCase = GetAccountsUseCase()
    private let createAccountUseCase = CreateAccountUseCase()
    private let archiveAccountUseCase = ArchiveAccountUseCase()
    private let deleteAccountUseCase = DeleteAccountUseCase()
    private let renameAccountUseCase = RenameAccountUseCase()
    
    private var accounts: [AccountsDTOs.ViewDidLoad.Response.Accounts.Account] = []
    
    init(view: AccountsViewController) {
        self.view = view
    }
    
    func onViewDidLoad(request: AccountsDTOs.ViewDidLoad.Request) {
        view?.viewDidLoad(response: .init(title: "Accounts"))
        
        getAccountsUseCase.execute(request: .init()) { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if case let .success(items) = response.result {
                    self.accounts = items.map {
                        AccountsDTOs.ViewDidLoad.Response.Accounts.Account(
                            id: $0.id, type: $0.type, title: $0.title, currency: $0.currency, total: $0.balance, isArchived: $0.isArchived
                        )
                    }
                    
                    self.view?.viewDidLoad(response: .init(accounts: self.accounts))
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
    
    func onArchiveAccount(request: AccountsDTOs.OnArchiveAccount.Request) {
        let account = accounts[request.index]
        
        archiveAccountUseCase.execute(request: .init(id: account.id)) { response in
            DispatchQueue.main.async {
                if case .success = response.result {
                    self.view?.onAdd(response: .init(title: "Account has been successfully archived"))
                } else {
                    self.view?.onAdd(response: .init(title: "Error"))
                }
            }
        }
    }
    
    func onDeleteAccount(request: AccountsDTOs.OnDeleteAccount.Request) {
        let account = accounts[request.index]
        
        deleteAccountUseCase.execute(request: .init(id: account.id)) { response in
            DispatchQueue.main.async {
                if case .success = response.result {
                    self.view?.onAdd(response: .init(title: "Account has been successfully deleted"))
                } else {
                    self.view?.onAdd(response: .init(title: "Error"))
                }
            }
        }
    }
    
    func onRenameAccount(request: AccountsDTOs.OnRenameAccount.Request) {
        let account = accounts[request.index]
        
        let requestAccount = UseCasesDTOs.RenameAccount.Request.Account(
            id: account.id, type: account.type, title: account.title, currency: account.currency, balance: account.total
        )
        
        renameAccountUseCase.execute(request: .init(title: request.title, account: requestAccount)) { response in
            DispatchQueue.main.async {
                if case .success = response.result {
                    self.view?.onAdd(response: .init(title: "Account has been successfully renamed"))
                } else {
                    self.view?.onAdd(response: .init(title: "Error"))
                }
            }
        }
    }
    
}
