//
//  LoginPresenter.swift
//  PiggyBank
//

import Foundation

class LoginPresenter {

    private weak var view: LoginViewController?
    private let signInUseCase: SignInUseCase

    init(view: LoginViewController?, signInUseCase: SignInUseCase) {
        self.view = view
        self.signInUseCase = signInUseCase
    }

    func onLoginPressed(username: String, password: String) {
        let domainSignInModel = DomainSignInModel(nickname: username, password: password)
        signInUseCase.execute(domainSignInModel: domainSignInModel) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    let profileViewController = DependencyProvider.shared.get(screen: .profile)
                    self?.view?.navigationController?.pushViewController(profileViewController, animated: true)
                case let .error(error):
                    var errorString = "Unknown error occured. Please contact support team."
                    switch error {
                    case let apiError as APIError:
                        switch apiError.type {
                        case .UserNotFound:
                            errorString = "Invalid username or password"
                        default:
                            errorString = apiError.errors.joined(separator: "\n")
                        }
                    case let internalError as InternalError:
                        errorString = internalError.string ?? errorString
                    default:
                        break
                    }
                    self?.view?.onLoginError(error: errorString)
                }
            }
        }
    }

}
