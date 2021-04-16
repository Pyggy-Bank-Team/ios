import Foundation

public final class AccountViewModel {
    
    enum AccountType: Int {
        
        case cash = 0
        case card = 1
        
    }
    
    let id: Int
    let type: AccountType
    let title: String
    let currency: String?
    let balance: Double
    let isArchived: Bool
    
    init(id: Int, type: AccountType, title: String, currency: String?, balance: Double, isArchived: Bool) {
        self.id = id
        self.type = type
        self.title = title
        self.currency = currency
        self.balance = balance
        self.isArchived = isArchived
    }
    
}
