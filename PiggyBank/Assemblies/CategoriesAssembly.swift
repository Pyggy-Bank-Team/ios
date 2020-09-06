import UIKit

final class CategoriesAssembly {
    
    func build() -> CategoriesViewController {
        let viewController = CategoriesViewController()
        let presenter = CategoriesPresenter(view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
}
