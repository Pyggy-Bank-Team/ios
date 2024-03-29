import Swinject
import SwinjectAutoregistration
import UIKit

final class AccountSceneAssembly: Assembly {

    let accountDomainModel: DomainAccountModel?

    init(accountDomainModel: DomainAccountModel?) {
        self.accountDomainModel = accountDomainModel
    }

    func assemble(container: Container) {
        container.autoregister(AccountDataSource.self, initializer: AccountRemoteDataSource.init)
        container.autoregister(AccountRepository.self, initializer: AccountDataRepository.init)
        container.autoregister(CreateUpdateAccountUseCase.self, initializer: CreateUpdateAccountUseCase.init)
        container.autoregister(DeleteAccountUseCase.self, initializer: DeleteAccountUseCase.init)

        container.register(AccountPresenter.self) { resolver in
            AccountPresenter(
                accountDomainModel: self.accountDomainModel,
                view: resolver.resolve(AccountViewController.self),
                createUpdateAccountUseCase: resolver.resolve(CreateUpdateAccountUseCase.self),
                deleteAccountUseCase: resolver.resolve(DeleteAccountUseCase.self)
            )
        }
        container.register(AccountViewController.self) { _ in AccountViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(AccountPresenter.self)
            }
    }

}
