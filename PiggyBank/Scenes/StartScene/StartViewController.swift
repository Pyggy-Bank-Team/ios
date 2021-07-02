import UIKit

final class StartViewController: UINavigationController {
    
    var presenter: StartPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.piggy.white
        
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.piggy.black
        ]
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.piggy.black
        ]

        presenter.viewDidLoad()
    }
    
    func viewDidLoad(vcs: [UIViewController]) {
        setViewControllers(vcs, animated: false)
    }

}
