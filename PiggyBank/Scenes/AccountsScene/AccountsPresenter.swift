import Foundation

final class AccountsPresenter {
    
    class SectionItem {
        
        let totalText: String?
        
        let separator: Bool
        
        let emptyText: String?
        
        let headerTitle: String?
        var accounts: [DomainAccountModel] = []
        
        init(totalText: String) {
            self.totalText = totalText
            
            separator = false
            headerTitle = nil
            emptyText = nil
        }
        
        init(headerTitle: String?) {
            self.headerTitle = headerTitle
            
            totalText = nil
            separator = false
            emptyText = nil
        }
        
        init(separator: Bool) {
            self.separator = separator
            
            totalText = nil
            headerTitle = nil
            emptyText = nil
        }
        
        init(emptyText: String) {
            self.emptyText = emptyText
            
            totalText = nil
            headerTitle = nil
            separator = false
        }

    }
    
    private weak var view: AccountsViewController?
    
    private let getAccountsUseCase: GetAccountsUseCase
    private let changeAndUpdateAccountsUseCase: ChangeAndUpdateAccountsUseCase
    private let deleteAndUpdateAccountsUseCase: DeleteAndUpdateAccountsUseCase
    
    private var sections: [SectionItem] = []
    
    init(
        view: AccountsViewController?,
        getAccountsUseCase: GetAccountsUseCase,
        changeAndUpdateAccountsUseCase: ChangeAndUpdateAccountsUseCase,
        deleteAndUpdateAccountsUseCase: DeleteAndUpdateAccountsUseCase
    ) {
        self.view = view
        self.getAccountsUseCase = getAccountsUseCase
        self.changeAndUpdateAccountsUseCase = changeAndUpdateAccountsUseCase
        self.deleteAndUpdateAccountsUseCase = deleteAndUpdateAccountsUseCase
    }
    
    func getAccount(at indexPath: IndexPath) -> DomainAccountModel {
        sections[indexPath.section].accounts[indexPath.row]
    }
    
    func getSection(at index: Int) -> SectionItem {
        sections[index]
    }
    
    func getAccounts() {
        getAccountsUseCase.execute { [weak self] response in
            self?.handleResponse(response)
        }
    }

    func archive(at indexPath: IndexPath) {
        let account = getAccount(at: indexPath)
        let newAccount = account.update(isArchived: !account.isArchived)
        
        changeAndUpdateAccountsUseCase.execute(category: newAccount) { [weak self] response in
            self?.handleResponse(response)
        }
    }
    
    func delete(at indexPath: IndexPath) {
        let account = getAccount(at: indexPath)
        deleteAndUpdateAccountsUseCase.execute(account: account) { [weak self] response in
            self?.handleResponse(response)
        }
    }

}

private extension AccountsPresenter {
    
    func handleResponse(_ response: Result<[DomainAccountModel]>) {
        if case let .success(accounts) = response {
            defer {
                DispatchQueue.main.async {
                    self.view?.sections = self.sections
                }
            }
            
            sections.removeAll()
            
            if accounts.isEmpty {
                let empty = SectionItem(emptyText: "No accounts")
                sections.append(empty)
                return
            }
            
            let separator = SectionItem(separator: true)
            let regularAccounts = SectionItem(headerTitle: nil)
            let archivedAccounts = SectionItem(headerTitle: "Archive")

            var totalSum: Double = 0
            accounts.forEach { account in
                if account.isArchived {
                    archivedAccounts.accounts.append(account)
                } else {
                    regularAccounts.accounts.append(account)
                }

                totalSum += account.balance
            }
            let total = SectionItem(totalText: totalSum.description)

            sections.removeAll()
            sections.append(total)
            sections.append(separator)
            if !regularAccounts.accounts.isEmpty {
                sections.append(regularAccounts)
            }
            if !archivedAccounts.accounts.isEmpty {
                sections.append(archivedAccounts)
            }
        }
    }
    
}
