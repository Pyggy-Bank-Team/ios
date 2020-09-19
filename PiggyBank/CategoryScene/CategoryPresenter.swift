import Foundation

final class CategoryPresenter {
    
    private let categoryDomainModel: DomainCategoryModel?
    
    private let createUpdateCategoryUseCase = CreateUpdateCategoryUseCase()
    private let deleteCategoryUseCase = DeleteCategoryUseCase()
    
    weak var view: CategoryViewController?
    
    init(categoryDomainModel: DomainCategoryModel?, view: CategoryViewController?) {
        self.categoryDomainModel = categoryDomainModel
        self.view = view
    }
    
    func loadData() {
        let categoryViewModel = GrandConverter.convertToViewModel(domainCategory: categoryDomainModel)
        view?.loadCategory(category: categoryViewModel)
    }
    
    func onSave() {
//        guard let view = view else {
//            fatalError("AccountPresenter: onSave - view is nil")
//        }
//
//        let accountCurrency: String?
//        let accountID: Int?
//
//        if let account = accountDomainModel {
//            accountCurrency = account.currency
//            accountID = account.id
//        } else {
//            accountCurrency = nil
//            accountID = nil
//        }
//
//        guard let accountType = DomainAccountModel.AccountType(rawValue: view.accountType) else {
//            fatalError("AccountPresenter: onSave - account type is invalid")
//        }
//
//        let accountTitle = view.accountTitle
//        let accountBalance = view.accountBalance
//        let accountArchive = view.accountArchived
//
//        let createUpdateDomain = DomainAccountModel(
//            id: accountID,
//            type: accountType.rawValue,
//            title: accountTitle,
//            currency: accountCurrency,
//            balance: accountBalance,
//            isArchived: accountArchive,
//            isDeleted: false
//        )
//
//        createUpdateAccountUseCase.execute(request: createUpdateDomain) { [weak self] result in
//            guard let self = self else { return }
//
//            if case .success = result {
//                DispatchQueue.main.async {
//                    self.view?.accountSaved()
//                }
//            }
//        }
    }
    
    func onDelete() {
        guard let id = categoryDomainModel?.id else {
            fatalError("AccountPresenter: onDelete - accountDomainModel?.id is nil")
        }
        
        deleteCategoryUseCase.execute(categoryID: id) { [weak self] result in
            guard let self = self else { return }
            
            if case .success = result {
                DispatchQueue.main.async {
                    self.view?.notifyFromAPI()
                }
            }
        }
    }
    
}

