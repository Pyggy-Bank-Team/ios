import UIKit

final class BaseCurrencySceneAssembly {
    
    private let initialNickname: String
    private let initialPassword: String
    
    init(initialNickname: String, initialPassword: String) {
        self.initialNickname = initialNickname
        self.initialPassword = initialPassword
    }
    
    func build() -> UIViewController {
        let viewController = BaseCurrencyViewController()
        let presenter = BaseCurrencyPresenter(initialNickname: initialNickname, initialPassword: initialPassword, view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
}
