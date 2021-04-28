import Swinject
import SwinjectAutoregistration
import UIKit

final class ProfileSceneAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(UserCredentialsRepository.self, initializer: UserCredentialsDataRepository.init)
        container.autoregister(DeleteUserCredentialsUseCase.self, initializer: DeleteUserCredentialsUseCase.init)
        container.autoregister(ProfilePresenter.self, initializer: ProfilePresenter.init)
        container.register(ProfileViewController.self) { _ in ProfileViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(ProfilePresenter.self)
            }
    }

}
