import UIKit

enum AuthSceneMode {
    
    case signIn
    case signUp
    
}

final class AuthSceneAssembly {
    
    let mode: AuthSceneMode
    
    init(mode: AuthSceneMode) {
        self.mode = mode
    }
    
    func build() -> UIViewController {
        let viewController = AuthViewController()
        let presenter = AuthPresenter(mode: mode, view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
}
