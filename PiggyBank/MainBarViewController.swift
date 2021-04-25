import UIKit

public final class MainBarViewController: UITabBarController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let accountsViewController = DependencyProvider.shared.assembler.resolver.resolve(AccountsViewController.self)!
        accountsViewController.tabBarItem = UITabBarItem(title: "Accounts", image: nil, tag: 0)
        
        let categoriesViewController = CategoriesViewController()
        categoriesViewController.tabBarItem = UITabBarItem(title: "Categories", image: nil, tag: 1)
        
        setViewControllers([
            accountsViewController, categoriesViewController
        ], animated: false)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
