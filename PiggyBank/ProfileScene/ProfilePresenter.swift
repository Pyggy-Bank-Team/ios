import Foundation

final class ProfilePresenter {
    
    private let deleteCredentials = DeleteUserCredentialsUseCase()
    
    private weak var view: ProfileViewController?
    
    init(view: ProfileViewController?) {
        self.view = view
    }
    
    func onSignOut() {
        deleteCredentials.execute { [weak self] _ in
            DispatchQueue.main.async {
                self?.view?.onSignOut()
            }
        }
    }
    
}
