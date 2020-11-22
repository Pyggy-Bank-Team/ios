import UIKit

final class OperationSceneAssembly {
    
    func build() -> UIViewController {
        let viewController = OperationViewController()
        let presenter = OperationPresenter(view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
}
