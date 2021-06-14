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
                if case .success = result {
                    self?.view?.navigationController?.pushViewController(DependencyProvider.shared.get(screen: .profile),
                                                                         animated: true)
                } else {
                    self?.view?.onLoginError()
                }
            }
        }
    }

}
