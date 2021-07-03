import Foundation

final class AccountsPresenter {
    
    class SectionItem {
        
        let total: Bool
        let totalText: String?
        
        let separator: Bool
        
        let headerTitle: String?
        
        var accounts: [DomainAccountModel] = []
        
        init(totalText: String) {
            self.totalText = totalText
            total = true
            
            separator = false
            headerTitle = nil
        }
        
        init(headerTitle: String) {
            self.headerTitle = headerTitle
            
            total = false
            totalText = nil
            separator = false
        }
        
        init(separator: Bool) {
            self.separator = separator
            
            total = false
            totalText = nil
            headerTitle = nil
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
            guard !accounts.isEmpty else { return }
            
            let separator = SectionItem(separator: true)
            let cashAccounts = SectionItem(headerTitle: "Cash")
            let cardAccounts = SectionItem(headerTitle: "Card")
            let archivedCashAccounts = SectionItem(headerTitle: "Archive • Cash")
            let archivedCardAccounts = SectionItem(headerTitle: "Archive • Card")

            var totalSum: Double = 0
            accounts.forEach { account in
                if account.type == .cash {
                    if account.isArchived {
                        archivedCashAccounts.accounts.append(account)
                    } else {
                        cashAccounts.accounts.append(account)
                    }
                } else {
                    if account.isArchived {
                        archivedCardAccounts.accounts.append(account)
                    } else {
                        cardAccounts.accounts.append(account)
                    }
                }
                
                totalSum += account.balance
            }
            let total = SectionItem(totalText: totalSum.description)

            sections.removeAll()
            sections.append(total)
            sections.append(separator)
            if !cashAccounts.accounts.isEmpty {
                sections.append(cashAccounts)
            }
            if !cardAccounts.accounts.isEmpty {
                sections.append(cardAccounts)
            }
            if !archivedCashAccounts.accounts.isEmpty {
                sections.append(archivedCashAccounts)
            }
            if !archivedCardAccounts.accounts.isEmpty {
                sections.append(archivedCardAccounts)
            }

            DispatchQueue.main.async {
                self.view?.sections = self.sections
            }
        }
    }
    
}
