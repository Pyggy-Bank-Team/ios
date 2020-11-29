import Foundation

final class GrandConverter {
    
    static func convertToViewModel(domainAccount: DomainAccountModel?) -> AccountViewModel? {
        guard let account = domainAccount else { return nil }
        
        return AccountViewModel(
            id: account.id!,
            type: account.type == .cash ? .cash : .card,
            title: account.title,
            currency: account.currency,
            balance: account.balance,
            isArchived: account.isArchived
        )
    }
    
    static func convertToViewModel(domainCategory: DomainCategoryModel?) -> CategoryViewModel? {
        guard let category = domainCategory else { return nil }
        
        return CategoryViewModel(
            id: category.id!,
            title: category.title,
            hexColor: category.hexColor,
            type: category.type == .income ? .income : .outcome,
            isArchived: category.isArchived
        )
    }
    
    
    static func convertToViewModel(domainCurrency: DomainCurrencyModel) -> CurrencyViewModel {
        return CurrencyViewModel(code: domainCurrency.code, symbol: domainCurrency.symbol)
    }
    
    static func convertToDomainModel(currencyResponse: CurrencyResponse) -> DomainCurrencyModel {
        return DomainCurrencyModel(code: currencyResponse.code, symbol: currencyResponse.symbol)
    }
    
    static func convertToRequestModel(domain: DomainSignUpModel) -> SignUpRequest {
        return SignUpRequest(nickname: domain.nickname, password: domain.password, currency: domain.currency)
    }

    static func convertToRequestModel(domain: DomainSignInModel) -> SignInRequest {
        return SignInRequest(nickname: domain.nickname, password: domain.password)
    }

    static func convertToRequestModel(domain: DomainCreateUpdateTransferOperationModel) -> CreateUpdateTransferOperationRequest {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        let date = formatter.string(from: domain.createdOn)

        return CreateUpdateTransferOperationRequest(createdOn: date, from: domain.from, to: domain.to, amount: domain.amount, comment: domain.comment)
    }
    
    static func convertToDomainModel(authResponse: UserCredentialsResponse) -> DomainAuthModel {
        return DomainAuthModel(accessToken: authResponse.accessToken)
    }
    
    static func convertToRequestModel(domain: DomainAccountModel) -> CreateUpdateAccountRequest {
        return CreateUpdateAccountRequest(
            type: domain.type.rawValue,
            title: domain.title,
            balance: domain.balance,
            isArchived: domain.isArchived
        )
    }
    
    static func convertToRequestModel(domain: DomainCategoryModel) -> CreateUpdateCategoryRequest {
        return CreateUpdateCategoryRequest(
            title: domain.title,
            hexColor: domain.hexColor,
            type: domain.type.rawValue,
            isArchived: domain.isArchived
        )
    }
    
    static func convertToDomain(response: AccountResponse) -> DomainAccountModel {
        return DomainAccountModel(
            id: response.id,
            type: response.type,
            title: response.title,
            currency: response.currency,
            balance: response.balance,
            isArchived: response.isArchived,
            isDeleted: response.isDeleted
        )
    }
    
    static func convertToDomain(response: CategoryResponse) -> DomainCategoryModel {
        return DomainCategoryModel(
            id: response.id,
            title: response.title,
            hexColor: response.hexColor,
            type: response.type,
            isArchived: response.isArchived,
            isDeleted: response.isDeleted
        )
    }
    
    static func convertToDomain(response: OperationResponse) -> DomainOperationModel {
        return DomainOperationModel(
            id: response.id,
            categoryID: response.categoryID,
            categoryHexColor: response.categoryHexColor,
            amount: response.amount,
            accountID: response.accountID,
            accountTitle: response.accountTitle,
            comment: response.comment,
            type: response.type,
            createdOn: response.createdOn,
            planDate: response.planDate,
            fromTitle: response.fromTitle,
            toTitle: response.toTitle,
            isDeleted: response.isDeleted
        )
    }
    
    static func convertToViewModel(operationModel: DomainOperationModel) -> OperationViewModel {
        let type: OperationViewModel.OperationType
        
        switch operationModel.type {
        case .transfer:
            type = .transfer
        case .budget:
            type = .budget
        case .plan:
            type = .plan
        }
        
        return OperationViewModel(id: operationModel.id, type: type)
    }
    
}
