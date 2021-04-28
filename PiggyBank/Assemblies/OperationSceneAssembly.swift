import Swinject
import SwinjectAutoregistration
import UIKit

final class OperationSceneAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(AccountDataSource.self, initializer: AccountRemoteDataSource.init)
        container.autoregister(AccountRepository.self, initializer: AccountDataRepository.init)
        container.autoregister(GetAccountsUseCase.self, initializer: GetAccountsUseCase.init)

        container.autoregister(OperationsDataSource.self, initializer: OperationsRemoteDataSource.init)
        container.autoregister(OperationsRepository.self, initializer: OperationsDataRepository.init)
        container.autoregister(CreateUpdateTransferOperationUseCase.self, initializer: CreateUpdateTransferOperationUseCase.init)

        container.autoregister(OperationPresenter.self, initializer: OperationPresenter.init)
        container.register(OperationViewController.self) { _ in OperationViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(OperationPresenter.self)
            }
    }

}
