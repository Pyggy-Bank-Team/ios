import Swinject
import SwinjectAutoregistration
import UIKit

final class OperationsSceneAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(OperationsDataSource.self, initializer: OperationsRemoteDataSource.init)
        container.autoregister(OperationsRepository.self, initializer: OperationsDataRepository.init)

        container.autoregister(GetOperationsUseCase.self, initializer: GetOperationsUseCase.init)
        container.autoregister(DeleteOperationUseCase.self, initializer: DeleteOperationUseCase.init)

        container.autoregister(OperationsPresenter.self, initializer: OperationsPresenter.init)
        container.register(OperationsViewController.self) { _ in OperationsViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(OperationsPresenter.self)
            }
    }

}
