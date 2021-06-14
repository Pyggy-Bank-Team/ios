import UIKit

final class StartPresenter {
    
    private weak var view: StartViewController?
    private let getUserCredentials: GetUserCredentialsUseCase?

    init(view: StartViewController?, getUserCredentials: GetUserCredentialsUseCase?) {
        self.view = view
        self.getUserCredentials = getUserCredentials
    }

    func viewDidLoad() {
        getUserCredentials?.execute { [weak self] result in
            if case let .success(model) = result {
                var vcs: [UIViewController] = [DependencyProvider.shared.get(screen: .home)]
                if model != nil {
                    vcs.append(DependencyProvider.shared.get(screen: .profile))
                }

                DispatchQueue.main.async {
                    self?.view?.viewDidLoad(vcs: vcs)
                }
            }
        }
    }

}
