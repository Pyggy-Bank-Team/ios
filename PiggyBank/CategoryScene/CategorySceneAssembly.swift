import UIKit

final class CategorySceneAssembly {
    
    let categoryDomainModel: DomainCategoryModel?
    
    init(categoryDomainModel: DomainCategoryModel?) {
        self.categoryDomainModel = categoryDomainModel
    }
    
    func build() -> UIViewController {
        let viewController = CategoryViewController()
        let presenter = CategoryPresenter(categoryDomainModel: categoryDomainModel, view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
}
