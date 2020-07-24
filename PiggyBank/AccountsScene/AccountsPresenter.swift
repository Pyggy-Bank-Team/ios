import Foundation

final class AccountsPresenter {
    
    private weak var view: AccountsViewController?
    
    private let getAccountsUseCase = GetAccountsUseCase()
    
    init(view: AccountsViewController) {
        self.view = view
    }
    
    func onViewDidLoad(request: AccountsDTOs.ViewDidLoad.Request) {
        view?.viewDidLoad(response: .init(title: "Accounts"))
        
        getAccountsUseCase.execute(request: .init()) { response in
            if case let .success(items) = response.result {
                items.forEach {
                    print($0.title)
                }
            }
        }
    }
    
}
