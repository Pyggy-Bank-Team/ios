//
//  LoginSceneAssembly.swift
//  PiggyBank
//

import Swinject
import UIKit

class LoginSceneAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(SignInDataSource.self, initializer: SignInRemoteDataSource.init)
        container.autoregister(SignInRepository.self, initializer: SignInDataRepository.init)

        container.autoregister(SaveUserCredentialsUseCase.self, initializer: SaveUserCredentialsUseCase.init)
        container.autoregister(SignInUseCase.self, initializer: SignInUseCase.init)

        container.autoregister(LoginPresenter.self, initializer: LoginPresenter.init)
        container.register(LoginViewController.self) { _ in LoginViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(LoginPresenter.self)
            }
    }
}
