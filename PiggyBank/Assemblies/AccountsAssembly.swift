import Swinject
import SwinjectAutoregistration
import UIKit

final class AccountsAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(AccountDataSource.self, initializer: AccountRemoteDataSource.init)
        container.autoregister(AccountRepository.self, initializer: AccountDataRepository.init)

        container.autoregister(GetAccountsUseCase.self, initializer: GetAccountsUseCase.init)
        container.autoregister(DeleteAccountUseCase.self, initializer: DeleteAccountUseCase.init)
        container.autoregister(CreateUpdateAccountUseCase.self, initializer: CreateUpdateAccountUseCase.init)

        container.autoregister(AccountsPresenter.self, initializer: AccountsPresenter.init)
        container.register(AccountsViewController.self) { _ in AccountsViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(AccountsPresenter.self)
            }
    }
}
