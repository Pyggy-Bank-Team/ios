import UIKit

final class StartSceneAssembly {
    
    func build() -> UIViewController {
        let viewController = StartViewController()
        let presenter = StartPresenter(view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
}
