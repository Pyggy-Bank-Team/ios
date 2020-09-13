import Foundation

final class AccountPresenter {
    
    private let accountDomainModel: DomainAccountModel?
    
    weak var view: AccountViewController?
    
    init(accountDomainModel: DomainAccountModel?, view: AccountViewController?) {
        self.accountDomainModel = accountDomainModel
        self.view = view
    }
    
    func loadAccount() {
        let accountViewModel = GrandConverter.convertToViewModel(domainAccount: accountDomainModel)
        view?.loadAccount(account: accountViewModel)
    }
    
}
