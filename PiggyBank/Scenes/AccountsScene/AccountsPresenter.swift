import Foundation

final class AccountsPresenter {
    
    private weak var view: AccountsViewController?
    
    private let getAccountsUseCase: GetAccountsUseCase?
    private let deleteAccountUseCase: DeleteAccountUseCase?
    private let createUpdateAccountUseCase: CreateUpdateAccountUseCase?
    
    private var accounts: [DomainAccountModel] = []
    
    init(
        view: AccountsViewController?,
        getAccountsUseCase: GetAccountsUseCase?,
        deleteAccountUseCase: DeleteAccountUseCase?,
        createUpdateAccountUseCase: CreateUpdateAccountUseCase?
    ) {
        self.view = view
        self.getAccountsUseCase = getAccountsUseCase
        self.deleteAccountUseCase = deleteAccountUseCase
        self.createUpdateAccountUseCase = createUpdateAccountUseCase
    }

    func onViewDidLoad(request: AccountsDTOs.ViewDidLoad.Request) {
        getAccountsUseCase?.execute { [weak self] response in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                if case let .success(items) = response {
                    self.accounts = items
                    
                    let accountsViewModels = items.compactMap { GrandConverter.convertToViewModel(domainAccount: $0) }
                    self.view?.viewDidLoad(response: .init(accountsViewModels))
                }
            }
        }
    }
    
    func onArchiveAccount(id: Int) {
        let account = getAccount(at: id)
        
        let createUpdateModel = DomainAccountModel(
            id: account.id,
            type: account.type.rawValue,
            title: account.title,
            currency: account.currency,
            balance: account.balance,
            isArchived: !account.isArchived,
            isDeleted: account.isDeleted
        )
        
        createUpdateAccountUseCase?.execute(request: createUpdateModel) { response in
            DispatchQueue.main.async {
                if case .success = response {
                    self.view?.onAdd(response: .init(title: "Account has been successfully \(account.isArchived ? "unarchived" : "archived")"))
                } else {
                    self.view?.onAdd(response: .init(title: "Error"))
                }
            }
        }
    }
    
    func onDeleteAccount(id: Int) {
        let account = getAccount(at: id)
        
        deleteAccountUseCase?.execute(accountID: account.id!) { response in
            DispatchQueue.main.async {
                if case .success = response {
                    self.view?.onAdd(response: .init(title: "Account has been successfully deleted"))
                } else {
                    self.view?.onAdd(response: .init(title: "Error"))
                }
            }
        }
    }
    
    func onAdd() {
        view?.onAdd(viewController: DependencyProvider.shared.get(screen: .account(nil)))
    }

    func onSelect(id: Int) {
        view?.onSelect(viewController: DependencyProvider.shared.get(screen: .account(getAccount(at: id))))
    }

}

extension AccountsPresenter {
    
    func getAccount(at id: Int) -> DomainAccountModel {
        accounts.first { $0.id == id }!
    }
    
}
