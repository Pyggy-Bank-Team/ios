import Swinject
import SwinjectAutoregistration
import UIKit

final class ProfileSceneAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(DeleteUserCredentialsRepository.self, initializer: DeleteUserCredentialsDataRepository.init)
        container.autoregister(DeleteUserCredentialsUseCase.self, initializer: DeleteUserCredentialsUseCase.init)
        container.autoregister(ProfilePresenter.self, initializer: ProfilePresenter.init)
        container.register(ProfileViewController.self) { _ in ProfileViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(ProfilePresenter.self)
            }
    }

}
