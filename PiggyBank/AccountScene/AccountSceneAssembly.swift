import UIKit

final class AccountSceneAssembly {
    
    let accountDomainModel: DomainAccountModel?
    
    init(accountDomainModel: DomainAccountModel?) {
        self.accountDomainModel = accountDomainModel
    }
    
    func build() -> UIViewController {
        let viewController = AccountViewController()
        let presenter = AccountPresenter(accountDomainModel: accountDomainModel, view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
}
