import Foundation

final class AccountsPresenter {
    
    private weak var view: AccountsViewController?
    
    private let getAccountsUseCase = GetAccountsUseCase()
    private let deleteAccountUseCase = DeleteAccountUseCase()
    private let createUpdateAccountUseCase = CreateUpdateAccountUseCase()
    
    private var accounts: [DomainAccountModel] = []
    
    init(view: AccountsViewController) {
        self.view = view
    }
    
    func onViewDidLoad(request: AccountsDTOs.ViewDidLoad.Request) {
        getAccountsUseCase.execute() { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if case let .success(items) = response {
                    self.accounts = items
                    
                    let accountsViewModels = items.compactMap { GrandConverter.convertToViewModel(domainAccount: $0) }
                    self.view?.viewDidLoad(response: .init(accountsViewModels))
                }
            }
        }
    }
    
    func onArchiveAccount(request: AccountsDTOs.OnArchiveAccount.Request) {
        let account = accounts[request.index]
        
        let createUpdateModel = DomainCreateUpdateAccountModel(
            id: account.id,
            type: account.type == .cash ? .cash : .card,
            title: account.title,
            currency: account.currency,
            balance: account.balance,
            isArchived: !account.isArchived
        )
        
        createUpdateAccountUseCase.execute(request: createUpdateModel) { response in
            DispatchQueue.main.async {
                if case .success = response {
                    self.view?.onAdd(response: .init(title: "Account has been successfully \(account.isArchived ? "unarchived" : "archived")"))
                } else {
                    self.view?.onAdd(response: .init(title: "Error"))
                }
            }
        }
    }
    
    func onDeleteAccount(request: AccountsDTOs.OnDeleteAccount.Request) {
        let account = accounts[request.index]
        
        deleteAccountUseCase.execute(accountID: account.id) { response in
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
        let accountVC = AccountSceneAssembly(accountDomainModel: nil).build()
        view?.onAdd(viewController: accountVC)
    }
    
    func onSelect(indexPath: IndexPath) {
        let account = accounts[indexPath.row]
        let accountVC = AccountSceneAssembly(accountDomainModel: account).build()
        view?.onSelect(viewController: accountVC)
    }
    
}
