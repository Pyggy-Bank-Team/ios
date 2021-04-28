import Foundation

final class ProfilePresenter {
    
    private let deleteCredentialsUseCase: DeleteUserCredentialsUseCase?
    private weak var view: ProfileViewController?
    
    init(view: ProfileViewController?, deleteCredentials: DeleteUserCredentialsUseCase?) {
        self.view = view
        self.deleteCredentialsUseCase = deleteCredentials
    }

    func onSignOut() {
        deleteCredentialsUseCase?.execute { [weak self] _ in
            DispatchQueue.main.async {
                self?.view?.onSignOut()
            }
        }
    }
    
}
