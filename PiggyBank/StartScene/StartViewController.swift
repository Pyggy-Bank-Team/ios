import UIKit

final class StartViewController: UINavigationController {
    
    var presenter: StartPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        presenter.viewDidLoad()
    }
    
    func viewDidLoad(vcs: [UIViewController]) {
        setViewControllers(vcs, animated: false)
    }

}
