import UIKit

final class ProfileSceneAssembly {
    
    func build() -> UIViewController {
        let viewController = ProfileViewController()
        let presenter = ProfilePresenter(view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
}
