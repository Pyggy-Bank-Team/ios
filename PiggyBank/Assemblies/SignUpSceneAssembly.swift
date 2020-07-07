import UIKit

final class SignUpSceneAssembly {
    
    func build() -> AuthViewController {
        let viewController = AuthViewController()
        let presenter = SignUpPresenter(view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
}
