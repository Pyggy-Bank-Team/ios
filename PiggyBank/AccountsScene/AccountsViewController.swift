import UIKit

final class AccountsViewController: UIViewController {
    
    var presenter: AccountsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        presenter.onViewDidLoad(request: .init())
    }
    
    func viewDidLoad(response: AccountsDTOs.ViewDidLoad.Response.Title) {
        navigationItem.title = response.title
    }

}
