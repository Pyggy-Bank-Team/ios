import Swinject
import UIKit

class StartSceneAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(GetUserCredentialsRepository.self, initializer: GetUserCredentialsDataRepository.init)
        container.autoregister(GetUserCredentialsUseCase.self, initializer: GetUserCredentialsUseCase.init)
        container.autoregister(StartPresenter.self, initializer: StartPresenter.init)
        container.register(StartViewController.self) { _ in StartViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(StartPresenter.self)
            }
    }
}
