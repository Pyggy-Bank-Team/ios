import UIKit

final class OperationsSceneAssembly {
    
    func build() -> UIViewController {
        let viewController = OperationsViewController()
        let presenter = OperationsPresenter(view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
}
