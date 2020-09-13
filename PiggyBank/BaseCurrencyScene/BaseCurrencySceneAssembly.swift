import UIKit

final class BaseCurrencySceneAssembly {
    
    func build() -> UIViewController {
        let viewController = BaseCurrencyViewController()
        let presenter = BaseCurrencyPresenter(view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
}
