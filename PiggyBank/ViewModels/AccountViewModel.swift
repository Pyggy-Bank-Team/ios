import Foundation

final class AccountViewModel {
    
    enum AccountType: Int {
        
        case cash
        case card
        
    }
    
    let type: AccountType
    let title: String
    let currency: String?
    let balance: Double
    let isArchived: Bool
    
    init(type: AccountType, title: String, currency: String?, balance: Double, isArchived: Bool) {
        self.type = type
        self.title = title
        self.currency = currency
        self.balance = balance
        self.isArchived = isArchived
    }
    
}
