import Swinject
import SwinjectAutoregistration
import UIKit

final class OperationSceneAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(GetAccountsDataSource.self, initializer: GetAccountsRemoteDataSource.init)
        container.autoregister(GetAccountsRepository.self, initializer: GetAccountsDataRepository.init)
        container.autoregister(GetAccountsUseCase.self, initializer: GetAccountsUseCase.init)

        container.autoregister(CreateUpdateTransferOperationDataSource.self, initializer: CreateUpdateTransferOperationRemoteDataSource.init)
        container.autoregister(CreateUpdateTransferOperationRepository.self, initializer: CreateUpdateTransferOperationDataRepository.init)
        container.autoregister(CreateUpdateTransferOperationUseCase.self, initializer: CreateUpdateTransferOperationUseCase.init)

        container.autoregister(OperationPresenter.self, initializer: OperationPresenter.init)
        container.register(OperationViewController.self) { _ in OperationViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(OperationPresenter.self)
            }
    }

}
