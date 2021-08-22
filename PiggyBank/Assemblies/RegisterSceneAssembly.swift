//
//  RegisterSceneAssembly.swift
//  PiggyBank
//

import Swinject
import UIKit

class RegisterSceneAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(SignUpDataSource.self, initializer: SignUpRemoteDataSource.init)
        container.autoregister(CurrenciesDataSource.self, initializer: CurrenciesRemoteDataSource.init)
        
        container.autoregister(SignUpRepository.self, initializer: SignUpDataRepository.init)
        container.autoregister(SignUpRepository.self, initializer: SignUpDataRepository.init)
        container.autoregister(CurrenciesRepository.self, initializer: CurrenciesDataRepository.init)
        
        container.autoregister(SaveUserCredentialsUseCase.self, initializer: SaveUserCredentialsUseCase.init)
        container.autoregister(SignUpUseCase.self, initializer: SignUpUseCase.init)
        container.autoregister(GetCurrenciesUseCase.self, initializer: GetCurrenciesUseCase.init)

        container.autoregister(RegisterPresenter.self, initializer: RegisterPresenter.init)
        container.register(RegisterViewController.self) { _ in RegisterViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(RegisterPresenter.self)
            }
    }
}
