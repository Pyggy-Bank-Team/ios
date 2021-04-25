import Swinject
import SwinjectAutoregistration
import UIKit

final class AccountsAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(GetAccountsDataSource.self, initializer: GetAccountsRemoteDataSource.init)
        container.autoregister(GetAccountsRepository.self, initializer: GetAccountsDataRepository.init)
        container.autoregister(GetAccountsUseCase.self, initializer: GetAccountsUseCase.init)

        container.autoregister(DeleteAccountDataSource.self, initializer: DeleteAccountRemoteDataSource.init)
        container.autoregister(DeleteAccountRepository.self, initializer: DeleteAccountDataRepository.init)
        container.autoregister(DeleteAccountUseCase.self, initializer: DeleteAccountUseCase.init)

        container.autoregister(CreateUpdateAccountDataSource.self, initializer: CreateUpdateAccountRemoteDataSource.init)
        container.autoregister(CreateUpdateAccountRepository.self, initializer: CreateUpdateAccountDataRepository.init)
        container.autoregister(CreateUpdateAccountUseCase.self, initializer: CreateUpdateAccountUseCase.init)

        container.autoregister(AccountsPresenter.self, initializer: AccountsPresenter.init)
        container.register(AccountsViewController.self) { _ in AccountsViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(AccountsPresenter.self)
            }
    }

}
