import Swinject
import SwinjectAutoregistration
import UIKit

final class OperationsSceneAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(GetOperationsDataSource.self, initializer: GetOperationsRemoteDataSource.init)
        container.autoregister(GetOperationsRepository.self, initializer: GetOperationsDataRepository.init)
        container.autoregister(GetOperationsUseCase.self, initializer: GetOperationsUseCase.init)

        container.autoregister(DeleteOperationDataSource.self, initializer: DeleteOperationRemoteDataSource.init)
        container.autoregister(DeleteOperationRepository.self, initializer: DeleteOperationDataRepository.init)
        container.autoregister(DeleteOperationUseCase.self, initializer: DeleteOperationUseCase.init)

        container.autoregister(OperationsPresenter.self, initializer: OperationsPresenter.init)
        container.register(OperationsViewController.self) { _ in OperationsViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(OperationsPresenter.self)
            }
    }

}
