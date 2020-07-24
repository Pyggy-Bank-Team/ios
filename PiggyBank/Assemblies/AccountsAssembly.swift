import UIKit

final class AccountsAssembly {
    
    func build() -> AccountsViewController {
        let viewController = AccountsViewController()
        let presenter = AccountsPresenter(view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
}
