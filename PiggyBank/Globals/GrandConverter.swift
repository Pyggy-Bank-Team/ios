import Foundation
import UIKit

public enum GrandConverter {
    
    static func convertToViewModel(domainAccount: DomainAccountModel?) -> AccountViewModel? {
        guard let account = domainAccount else {
            return nil
        }
        
        return AccountViewModel(
            id: account.id!,
            type: account.type == .cash ? .cash : .card,
            title: account.title,
            currency: account.currency,
            balance: account.balance,
            isArchived: account.isArchived
        )
    }
    
    static func convertToViewModel(domainCurrency: DomainCurrencyModel) -> CurrencyViewModel {
        CurrencyViewModel(code: domainCurrency.code, symbol: domainCurrency.symbol)
    }
    
    static func convertToDomainModel(currencyResponse: Currency.Response) -> DomainCurrencyModel {
        DomainCurrencyModel(code: currencyResponse.code, symbol: currencyResponse.symbol)
    }
    
    static func convertToRequestModel(domain: DomainSignUpModel) -> SignUp.Request {
        SignUp.Request(nickname: domain.nickname, password: domain.password, currency: domain.currency)
    }

    static func convertToRequestModel(domain: DomainSignInModel) -> SignIn.Request {
        SignIn.Request(nickname: domain.nickname, password: domain.password)
    }

    static func convertToRequestModel(domain: DomainCreateUpdateTransferOperationModel) -> CreateUpdateTransferOperation.Request {
        CreateUpdateTransferOperation.Request(
            createdOn: domain.createdOn.stringFromDate(),
            from: domain.from,
            to: domain.to,
            amount: domain.amount,
            comment: domain.comment
        )
    }
    
    static func convertToDomainModel(authResponse: UserCredentials.Response) -> DomainAuthModel {
        DomainAuthModel(accessToken: authResponse.accessToken)
    }
    
    static func convertToRequestModel(domain: DomainAccountModel) -> CreateUpdateAccount.Request {
        CreateUpdateAccount.Request(
            type: domain.type.rawValue,
            title: domain.title,
            balance: domain.balance,
            isArchived: domain.isArchived
        )
    }

    static func convertToRequestModel(domain: DomainCategoryModel) -> CreateUpdateCategory.Request {
        CreateUpdateCategory.Request(
            title: domain.title,
            hexColor: domain.hexColor,
            type: domain.type.rawValue,
            isArchived: domain.isArchived
        )
    }

    static func convertToRequestModel(
        category: DomainCategoryModel.CategoryType,
        fromDate: Date,
        toDate: Date
    ) -> Reports.Request {
        Reports.Request(type: category.rawValue, from: fromDate.stringFromDate(), to: toDate.stringFromDate())
    }

    static func convertToDomain(response: Account.Response) -> DomainAccountModel {
        DomainAccountModel(
            id: response.id,
            type: response.type,
            title: response.title,
            currency: response.currency,
            balance: response.balance,
            isArchived: response.isArchived,
            isDeleted: response.isDeleted
        )
    }
    
    static func convertToDomain(response: Category.Response) -> DomainCategoryModel {
        DomainCategoryModel(
            id: response.id,
            title: response.title,
            hexColor: response.hexColor,
            type: response.type,
            isArchived: response.isArchived,
            isDeleted: response.isDeleted
        )
    }
    
    static func convertToDomain(response: Operation.Response) -> DomainOperationModel {
        var category: DomainCategoryModel?
        if let responseCategory = response.category {
            category = DomainCategoryModel(title: responseCategory.title, hexColor: responseCategory.hexColor, type: responseCategory.type)
        }
        
        let fromAccount = DomainAccountModel(title: response.account.title, currency: response.account.currency)
        var toAccount: DomainAccountModel?
        if let responseAccount = response.toAcount {
            toAccount = DomainAccountModel(title: responseAccount.title, currency: responseAccount.currency)
        }
        
        return DomainOperationModel(id: response.id,
                                    amount: response.amount,
                                    comment: response.comment,
                                    type: response.type,
                                    date: response.date,
                                    category: category,
                                    fromAccount: fromAccount,
                                    toAccount: toAccount,
                                    isDeleted: response.isDeleted)
    }

    static func convertToDomain(response: Reports.Response) -> DomainCategoryReportModel {
        DomainCategoryReportModel(categoryId: response.categoryId,
                                  categoryTitle: response.categoryTitle,
                                  categoryHexColor: response.categoryHexColor,
                                  amount: Int64(response.amount),
                                  currency: response.currency)
    }

    static func convertToViewModel(domainModel: DomainCategoryReportModel) -> ReportViewModel.ReportCategory {
        ReportViewModel.ReportCategory(color: UIColor(hexString: domainModel.categoryHexColor),
                                       name: domainModel.categoryTitle,
                                       amount: domainModel.amount,
                                       currency: domainModel.currency.getCurrencySymbol() ?? domainModel.currency)
    }
}
