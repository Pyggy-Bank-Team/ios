import UIKit

final class SignInSceneAssembly {
    
    func build() -> AuthViewController {
        let viewController = AuthViewController()
        let presenter = SignInPresenter(view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
}
