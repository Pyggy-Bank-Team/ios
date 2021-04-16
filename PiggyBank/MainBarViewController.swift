import UIKit

public final class MainBarViewController: UITabBarController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let accountsViewController = AccountsAssembly().build()
        accountsViewController.tabBarItem = UITabBarItem(title: "Accounts", image: nil, tag: 0)
        
        let categoriesViewController = CategoriesViewController()
        categoriesViewController.tabBarItem = UITabBarItem(title: "Categories", image: nil, tag: 1)
        
        setViewControllers([
            accountsViewController, categoriesViewController
        ], animated: false)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
