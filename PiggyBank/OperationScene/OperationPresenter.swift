import Foundation

final class OperationPresenter {
    
    private weak var view: OperationViewController?

    private let getAccountsUseCase = GetAccountsUseCase()
    private let createUpdateTransferOperationUseCase = CreateUpdateTransferOperationUseCase()

    private var accounts: [DomainAccountModel] = []
    
    init(view: OperationViewController) {
        self.view = view
    }

    func onViewDidLoad() {
        getAccountsUseCase.execute { [weak self] accounts in
            if case let .success(items) = accounts {
                self?.accounts = items

                DispatchQueue.main.async {
                    self?.view?.itemsLoaded(items: items.map { $0.title })
                }
            }
        }
    }

    func onCreate() {
        guard let view = view else {
            return
        }

        let targetAccount = accounts[view.targetAccount]
        let sourceAccount = accounts[view.sourceAccount]
        let total = view.total
        let date = view.transferDate
        let comment = ""

        let model = DomainCreateUpdateTransferOperationModel(
            createdOn: date,
            from: sourceAccount.id!,
            to: targetAccount.id!,
            amount: total,
            comment: comment
        )

        createUpdateTransferOperationUseCase.execute(request: model) { [weak self] result in
            if case .success = result {
                DispatchQueue.main.async {
                    self?.view?.show(alert: "Success")
                }
            }
        }
    }
}

