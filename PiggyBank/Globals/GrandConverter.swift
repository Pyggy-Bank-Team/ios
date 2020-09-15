import Foundation

final class GrandConverter {
    
    static func convertToViewModel(domainAccount: DomainAccountModel?) -> AccountViewModel? {
        guard let account = domainAccount else { return nil }
        
        return AccountViewModel(
            type: account.type == .cash ? .cash : .card,
            title: account.title,
            currency: account.currency,
            balance: account.balance,
            isArchived: account.isArchived
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
    
    static func convertToDomainModel(authResponse: UserCredentialsResponse) -> DomainAuthModel {
        return DomainAuthModel(accessToken: authResponse.accessToken, refreshToken: authResponse.refreshToken)
    }
    
    static func convertToRequestModel(domain: DomainArchiveAccountModel) -> ArchiveAccountRequest {
        return ArchiveAccountRequest(id: domain.id, isArchived: domain.isArchived)
    }
    
}
